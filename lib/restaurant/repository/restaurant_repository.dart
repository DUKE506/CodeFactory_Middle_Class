import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/http.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:section2/common/const/data.dart';
import 'package:section2/common/dio/dio.dart';
import 'package:section2/common/model/cursor_pagenation_model.dart';
import 'package:section2/common/model/pagination_params.dart';
import 'package:section2/restaurant/model/restaurant_detail_model.dart';
import 'package:section2/restaurant/model/restaurant_model.dart';

part 'restaurant_repository.g.dart';

@riverpod
RestaurantRepository restaurantRepository(ref) {
  {
    final dio = ref.watch(dioStateProvider);
    final repository =
        RestaurantRepository(dio, baseUrl: 'http://$ip/restaurant');
    return repository;
  }
}

@RestApi()
abstract class RestaurantRepository {
  // http://$ip/restaurant
  factory RestaurantRepository(Dio dio, {String baseUrl}) =
      _RestaurantRepository;

  @GET('/')
  @Headers({
    'accessToken': 'true',
  })
  Future<CursorPagenation<RestaurantModel>> pagenate({
    @Queries() PaginationParams? paginationParams = const PaginationParams(),
  });

  @GET('/{id}')
  @Headers({
    'accessToken': 'true',
  })
  Future<RestaurantDetailModel> getRestaurantDetail({
    @Path() required String id,
  });
}
