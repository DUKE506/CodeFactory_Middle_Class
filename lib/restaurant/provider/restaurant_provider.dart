import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:section2/common/model/cursor_pagenation_model.dart';
import 'package:section2/common/model/pagination_params.dart';
import 'package:section2/restaurant/model/restaurant_model.dart';
import 'package:section2/restaurant/repository/restaurant_repository.dart';

final restaurantDetailProvider = Provider.family<RestaurantModel?, String>(
  (ref, id) {
    final state = ref.watch(restaurantProvider);

    //데이터가 없는 경우
    if (state is! CursorPagenation) {
      return null;
    }

    return state.data.firstWhere((data) => data.id == id);
  },
);

final restaurantProvider =
    StateNotifierProvider<RestaurantStateNotifier, CursorPaginationBase>((ref) {
  final repo = ref.watch(restaurantRepositoryProvider);
  final notifier = RestaurantStateNotifier(repository: repo);
  return notifier;
});

class RestaurantStateNotifier extends StateNotifier<CursorPaginationBase> {
  final RestaurantRepository repository;

  RestaurantStateNotifier({
    required this.repository,
  }) : super(CursorPagenationLoading()) {
    pagenate();
  }

  Future<void> pagenate({
    int fetchCount = 20,
    bool fetchMore = false,
    //강제 다시 로딩
    //true - CursorPaginationLoading()
    bool forceRefetch = false,
  }) async {
    try {
      // final res = await repository.pagenate();
      // state = res;

      //State 상태
      // CursorPagination - 정상적으로 데이터가 존재
      // CursorPaginationLoading - 데이터 로딩중(현재 캐시 없음)
      // CursorPaginationeError - 에러 존재
      // CursorPaginationRefetching - 첫 번째 페이지부터 다시 데이터 가져올때
      // CursorPaginationFetchMore - 추가데이터를 받아오라는 상태

      // 바로 반환하는 상황
      // 1) hasMore = false (기존 상태에서 이미 다음 데이터가 없다는 값을 가짐)
      // 2) 로딩중 - fetchMore : true
      //    로딩중 - fetchMore : false - 새로고침의 의도가 있을 수 있음

      if (state is CursorPagenation && !forceRefetch) {
        final pState = state as CursorPagenation;

        //추가로 데이터를 가져올 필요가없음
        if (!pState.meta.hasMore) {
          return;
        }
      }

      final isLoading = state is CursorPagenationLoading;
      final isRefetching = state is CursorPagenationRefetching;
      final isFetchMore = state is CursorPaginationFetchingMore;

      //2번 상황
      if (fetchMore && (isLoading || isRefetching || isFetchMore)) {
        return;
      }

      //paginationParams 생성
      PaginationParams paginationParams = PaginationParams(
        count: fetchCount,
      );

      //fetchMore
      //데이터를 추가로 더 가져오는 상황
      if (fetchMore) {
        final pState = state as CursorPagenation;

        state = CursorPaginationFetchingMore(
          meta: pState.meta,
          data: pState.data,
        );

        paginationParams = paginationParams.copyWith(
          after: pState.data.last.id,
        );
      }
      //데이터를 처음부터 가져오는 상황
      else {
        //데이터가 존재한다면 기존 데이터를 보존핸채로 요청
        if (state is CursorPagenation && !forceRefetch) {
          final pState = state as CursorPagenation;
          state = CursorPagenationRefetching(
            meta: pState.meta,
            data: pState.data,
          );
        } else {
          state = CursorPagenationLoading();
        }
      }

      final res = await repository.pagenate(paginationParams: paginationParams);

      if (state is CursorPaginationFetchingMore) {
        final pState = state as CursorPaginationFetchingMore;

        //기존 데이터 + 새로운 데이터 추가
        state = res.copyWith(
          data: [
            ...pState.data,
            ...res.data,
          ],
        );
      } else {
        state = res;
      }
    } catch (e) {
      state = CursorPaginationError(message: '데이터를 가져오지 못했습니다.');
    }
  }

  void getDetail({required String id}) async {
    //만약에 데이터가 하나도 없다면 리턴 (CursorPagination이 아니라면)
    // 데이터를 가져오는 시도
    if (state is! CursorPagenation) {
      await this.pagenate();
    }

    //CursorPagination이 아니라면 그냥 리턴
    if (state is! CursorPagenation) {
      return;
    }

    final pState = state as CursorPagenation;

    final res = await repository.getRestaurantDetail(id: id);

    state = pState.copyWith(
        data: pState.data
            .map<RestaurantModel>((e) => e.id == id ? res : e)
            .toList());
  }
}
