import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:section2/common/component/utils/data_utils.dart';
import 'package:section2/common/const/data.dart';
import 'package:section2/restaurant/component/restaurant_card.dart';

part 'restaurant_model.g.dart';

enum PriceRange {
  expensive,
  medium,
  cheap,
}

@JsonSerializable()
class RestaurantModel {
  final String id;
  final String name;
  @JsonKey(
    fromJson: DataUtils.pathToUrl,
  )
  final String thumbUrl;
  final List<String> tags;
  final PriceRange priceRange;
  final double ratings;
  final int ratingsCount;
  final int deliveryTime;
  final int deliveryFee;

  RestaurantModel({
    required this.id,
    required this.name,
    required this.thumbUrl,
    required this.tags,
    required this.priceRange,
    required this.ratings,
    required this.ratingsCount,
    required this.deliveryTime,
    required this.deliveryFee,
  });

  //json에서 인스턴스로 변경
  factory RestaurantModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$RestaurantModelFromJson(json);

  //인스턴스에서 json으로 변경
  Map<String, dynamic> toJson() => _$RestaurantModelToJson(this);

  // factory RestaurantModel.fromJson({
  //   required Map<String, dynamic> json,
  // }) {
  //   return RestaurantModel(
  //     id: json['id'],
  //     name: json['name'],
  //     thumbUrl: 'http://$ip${json['thumbUrl']}',
  //     tags: List<String>.from(json['tags']),
  //     priceRange: PriceRange.values.firstWhere(
  //       (value) => value.name == json['priceRange'],
  //     ),
  //     ratings: (json['ratings'] as num).toDouble(),
  //     ratingsCount: json['ratingsCount'],
  //     deliveryTime: json['deliveryTime'],
  //     deliveryFee: json['deliveryFee'],
  //   );
  // }
}
