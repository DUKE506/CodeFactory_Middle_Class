import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:section2/common/const/data.dart';
import 'package:section2/restaurant/component/restaurant_card.dart';
import 'package:section2/restaurant/model/restaurant_model.dart';
import 'package:section2/restaurant/view/restaurant_detail_screen.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({super.key});

  Future<List> pagenateRestaurant() async {
    final dio = Dio();

    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);

    final res = await dio.get(
      'http://$ip/restaurant',
      options: Options(
        headers: {
          'authorization': 'Bearer $accessToken',
        },
      ),
    );
    return res.data['data'];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: FutureBuilder<List>(
          future: pagenateRestaurant(),
          builder: (context, snapshot) {
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
                final item = snapshot.data![index];
                final pItem = RestaurantModel.fromJson(json: item);
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => RestaurantDetailScreen(),
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
