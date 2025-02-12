import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:section2/common/const/colors.dart';
import 'package:section2/common/const/data.dart';
import 'package:section2/common/dio/dio.dart';
import 'package:section2/common/layout/default_layout.dart';
import 'package:section2/product/component/product_card.dart';
import 'package:section2/product/model/product_model.dart';
import 'package:section2/restaurant/component/restaurant_card.dart';
import 'package:section2/restaurant/model/restaurant_detail_model.dart';
import 'package:section2/restaurant/model/restaurant_model.dart';
import 'package:section2/restaurant/repository/restaurant_repository.dart';

class RestaurantDetailScreen extends ConsumerWidget {
  final String restaurantId;
  final String restaurantName;

  const RestaurantDetailScreen({
    super.key,
    required this.restaurantId,
    required this.restaurantName,
  });

  //상세 정보 조회 API
  Future<RestaurantDetailModel> getRestaurantProducts(WidgetRef ref) async {
    final dio = ref.read(dioStateProvider);

    final repository =
        RestaurantRepository(dio, baseUrl: 'http://$ip/restaurant');

    return repository.getRestaurantDetail(id: restaurantId);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultLayout(
        title: restaurantName,
        floatingActionButton: _FloatingActionButton(),
        child: FutureBuilder<RestaurantDetailModel>(
            future: getRestaurantProducts(ref),
            builder: (context, AsyncSnapshot<RestaurantDetailModel> snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              }
              if (!snapshot.hasData &&
                  snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (!snapshot.hasData) {
                return Container();
              }

              // final item = RestaurantDetailModel.fromJson(snapshot.data!);

              return CustomScrollView(
                slivers: [
                  renderTop(model: snapshot.data!),
                  renderLabel(),
                  renderProduct(products: snapshot.data!.products),
                ],
              );
            }));
  }

  //
  FloatingActionButton _FloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {},
      child: Icon(
        Icons.shopping_basket_outlined,
        color: Colors.white,
      ),
      shape: CircleBorder(),
      backgroundColor: PRIMARY_COLOR,
    );
  }

  //가게 정보
  SliverToBoxAdapter renderTop({
    required RestaurantDetailModel model,
  }) {
    return SliverToBoxAdapter(
      child: RestaurantCard.fromModel(
        model: model,
        isDetail: true,
      ),
    );
  }

  //가게 메뉴 리스트
  SliverPadding renderProduct({
    required List<RestaurantProductModel> products,
  }) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final model = products[index];
            return Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: ProductCard.fromModel(
                model: model,
              ),
            );
          },
          childCount: products.length,
        ),
      ),
    );
  }

  SliverPadding renderLabel() {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      sliver: SliverToBoxAdapter(
        child: Text(
          '메뉴',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
