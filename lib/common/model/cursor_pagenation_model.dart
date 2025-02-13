import 'package:json_annotation/json_annotation.dart';

part 'cursor_pagenation_model.g.dart';

abstract class CursorPaginationBase {}

class CursorPaginationError extends CursorPaginationBase {
  final String message;

  CursorPaginationError({
    required this.message,
  });
}

class CursorPagenationLoading extends CursorPaginationBase {}

@JsonSerializable(
  genericArgumentFactories: true,
)
class CursorPagenation<T> extends CursorPaginationBase {
  final CursorPagenationMeta meta;
  final List<T> data;

  CursorPagenation({
    required this.meta,
    required this.data,
  });

  CursorPagenation copyWith({
    CursorPagenationMeta? meta,
    List<T>? data,
  }) {
    return CursorPagenation(
      meta: meta ?? this.meta,
      data: data ?? this.data,
    );
  }

  factory CursorPagenation.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJosnT) =>
      _$CursorPagenationFromJson(json, fromJosnT);
}

@JsonSerializable()
class CursorPagenationMeta {
  final int count;
  final bool hasMore;

  CursorPagenationMeta({
    required this.count,
    required this.hasMore,
  });

  CursorPagenationMeta copyWith({
    int? count,
    bool? hasMore,
  }) {
    return CursorPagenationMeta(
      count: count ?? this.count,
      hasMore: hasMore ?? this.hasMore,
    );
  }

  factory CursorPagenationMeta.fromJson(Map<String, dynamic> json) =>
      _$CursorPagenationMetaFromJson(json);
}

class CursorPagenationRefetching<T> extends CursorPagenation<T> {
  CursorPagenationRefetching({
    required super.meta,
    required super.data,
  });
}

// 리스
class CursorPaginationFetchingMore<T> extends CursorPagenation<T> {
  CursorPaginationFetchingMore({
    required super.meta,
    required super.data,
  });
}
