import 'package:flutter/material.dart';
import 'package:section2/common/layout/default_layout.dart';
import 'package:section2/restaurant/component/restaurant_card.dart';

class RestaurantDetailScreen extends StatelessWidget {
  const RestaurantDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '불떡',
      child: Column(
        children: [
          RestaurantCard(
            image: Image.asset('asset/img/food/ddeok_bok_gi.jpg'),
            name: '하이',
            tags: ['A', 'B', 'C'],
            ratingsCount: 5,
            deliveryTime: 15,
            deliveryFee: 2000,
            ratings: 4.5,
            isDetail: true,
            detail: '안녕하세요 맛있는 불떡입니다.',
          ),
          Column(
            children: [],
          )
        ],
      ),
    );
  }
}
