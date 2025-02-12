import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:section2/common/const/data.dart';
import 'package:section2/common/dio/dio.dart';
import 'package:section2/restaurant/component/restaurant_card.dart';
import 'package:section2/restaurant/model/restaurant_model.dart';
import 'package:section2/restaurant/repository/restaurant_repository.dart';
import 'package:section2/restaurant/view/restaurant_detail_screen.dart';

class RestaurantScreen extends ConsumerWidget {
  const RestaurantScreen({super.key});

  Future<List<RestaurantModel>> pagenateRestaurant(WidgetRef ref) async {
    final dio = ref.read(dioStateProvider);
    // final dio = Dio();

    // dio.interceptors.add(CustomInterceptor(storage: storage));

    final res =
        await RestaurantRepository(dio, baseUrl: 'http://$ip/restaurant')
            .pagenate();

    return res.data;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: FutureBuilder<List<RestaurantModel>>(
          future: pagenateRestaurant(ref),
          builder: (context, AsyncSnapshot<List<RestaurantModel>> snapshot) {
            //데이터 조회중인 경우
            if (!snapshot.hasData &&
                snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (!snapshot.hasData) {
              return Container();
            }

            return ListView.separated(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final pItem = snapshot.data![index];

                return GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => RestaurantDetailScreen(
                          restaurantId: pItem.id,
                          restaurantName: pItem.name,
                        ),
                      ),
                    );
                  },
                  child: RestaurantCard.fromModel(
                    model: pItem,
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 16.0,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
