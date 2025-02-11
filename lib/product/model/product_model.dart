import 'package:section2/restaurant/model/restaurant_model.dart';

class ProductModel {
  final String id;
  final String detail;
  final String name;
  final String imgUrl;
  final int price;

  //모델 생성자
  ProductModel({
    required this.id,
    required this.detail,
    required this.name,
    required this.imgUrl,
    required this.price,
  });

  factory ProductModel.fromJson({required Map<String, dynamic> json}) {
    return ProductModel(
      id: json['id'],
      detail: json['detail'],
      name: json['name'],
      imgUrl: json['imgUrl'],
      price: json['price'],
    );
  }
}
