import 'package:json_annotation/json_annotation.dart';

part 'cursor_pagenation_model.g.dart';

@JsonSerializable(
  genericArgumentFactories: true,
)
class CursorPagenation<T> {
  final CursorPagenationMeta meta;
  final List<T> data;

  CursorPagenation({
    required this.meta,
    required this.data,
  });

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

  factory CursorPagenationMeta.fromJson(Map<String, dynamic> json) =>
      _$CursorPagenationMetaFromJson(json);
}
