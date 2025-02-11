import 'package:json_annotation/json_annotation.dart';
import 'package:section2/common/component/utils/data_utils.dart';
import 'package:section2/common/const/data.dart';
import 'package:section2/product/model/product_model.dart';
import 'package:section2/restaurant/model/restaurant_model.dart';

part 'restaurant_detail_model.g.dart';

@JsonSerializable()
class RestaurantDetailModel extends RestaurantModel {
  final String detail;
  final List<RestaurantProductModel> products;

  RestaurantDetailModel({
    required super.id,
    required super.name,
    @JsonKey(
      fromJson: DataUtils.pathToUrl,
    )
    required super.thumbUrl,
    required super.tags,
    required super.priceRange,
    required super.ratings,
    required super.ratingsCount,
    required super.deliveryTime,
    required super.deliveryFee,
    required this.detail,
    required this.products,
  });

  factory RestaurantDetailModel.fromJson(Map<String, dynamic> json) =>
      _$RestaurantDetailModelFromJson(json);

  // factory RestaurantDetailModel.fromJson({
  //   required Map<String, dynamic> json,
  // }) {
  //   return RestaurantDetailModel(
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
  //     detail: json['detail'],
  //     products: json['products']
  //         .map<RestaurantProductModel>(
  //           (product) => RestaurantProductModel.fromJson(
  //             json: product,
  //           ),
  //         )
  //         .toList(),
  //   );
  // }
}

@JsonSerializable()
class RestaurantProductModel {
  final String id;
  final String name;
  @JsonKey(
    fromJson: DataUtils.pathToUrl,
  )
  final String imgUrl;
  final String detail;
  final int price;

  RestaurantProductModel({
    required this.id,
    required this.name,
    required this.imgUrl,
    required this.detail,
    required this.price,
  });

  factory RestaurantProductModel.fromJson(Map<String, dynamic> json) =>
      _$RestaurantProductModelFromJson(json);

  // factory RestaurantProductModel.fromJson({
  //   required Map<String, dynamic> json,
  // }) {
  //   return RestaurantProductModel(
  //     id: json['id'],
  //     detail: json['detail'],
  //     name: json['name'],
  //     imgUrl: 'http://$ip${json['imgUrl']}',
  //     price: json['price'],
  //   );
  // }
}
