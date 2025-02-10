import 'package:section2/restaurant/model/restaurant_model.dart';

class ProductModel {
  final String id;
  final RestaurantModel restaurant;
  final String detail;
  final String name;
  final String imgUrl;
  final int price;

  //모델 생성자
  ProductModel({
    required this.id,
    required this.restaurant,
    required this.detail,
    required this.name,
    required this.imgUrl,
    required this.price,
  });
}
