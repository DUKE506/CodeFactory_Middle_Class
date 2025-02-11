// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cursor_pagenation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CursorPagenation<T> _$CursorPagenationFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    CursorPagenation<T>(
      meta: CursorPagenationMeta.fromJson(json['meta'] as Map<String, dynamic>),
      data: (json['data'] as List<dynamic>).map(fromJsonT).toList(),
    );

Map<String, dynamic> _$CursorPagenationToJson<T>(
  CursorPagenation<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'meta': instance.meta,
      'data': instance.data.map(toJsonT).toList(),
    };

CursorPagenationMeta _$CursorPagenationMetaFromJson(
        Map<String, dynamic> json) =>
    CursorPagenationMeta(
      count: (json['count'] as num).toInt(),
      hasMore: json['hasMore'] as bool,
    );

Map<String, dynamic> _$CursorPagenationMetaToJson(
        CursorPagenationMeta instance) =>
    <String, dynamic>{
      'count': instance.count,
      'hasMore': instance.hasMore,
    };
