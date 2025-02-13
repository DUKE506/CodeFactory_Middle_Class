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
import 'package:section2/restaurant/provider/restaurant_provider.dart';
import 'package:section2/restaurant/repository/restaurant_repository.dart';
import 'package:skeletonizer/skeletonizer.dart';

class RestaurantDetailScreen extends ConsumerStatefulWidget {
  final String restaurantId;
  final String restaurantName;

  const RestaurantDetailScreen({
    super.key,
    required this.restaurantId,
    required this.restaurantName,
  });

  @override
  ConsumerState<RestaurantDetailScreen> createState() =>
      _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState
    extends ConsumerState<RestaurantDetailScreen> {
  @override
  void initState() {
    super.initState();

    ref.read(restaurantProvider.notifier).getDetail(id: widget.restaurantId);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(restaurantDetailProvider(widget.restaurantId));

    if (state == null) {
      return DefaultLayout(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return DefaultLayout(
      title: widget.restaurantName,
      floatingActionButton: _FloatingActionButton(),
      child: CustomScrollView(
        slivers: [
          renderTop(model: state),
          if (state is RestaurantDetailModel) renderLabel(),
          if (state is RestaurantDetailModel)
            renderProduct(
              products: state.products,
            ),
        ],
      ),
    );
  }

  // SliverPadding renderLoading() {
  //   return SliverPadding(
  //     padding: EdgeInsets.symmetric(
  //       horizontal: 16.0,
  //     ),
  //     sliver: SliverList(
  //         delegate: SliverChildListDelegate(
  //       List.generate(
  //         3,
  //         (index) {
  //           return Skeletonizer(child: );
  //         },
  //       ),
  //     )),
  //   );
  // }

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
    required RestaurantModel model,
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
      sliver: Skeletonizer(
        child: SliverList(
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
