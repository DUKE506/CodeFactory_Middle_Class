import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:section2/common/const/data.dart';
import 'package:section2/common/layout/default_layout.dart';
import 'package:section2/restaurant/component/restaurant_card.dart';
import 'package:section2/restaurant/model/restaurant_model.dart';

class RestaurantDetailScreen extends StatelessWidget {
  final String restaurantId;
  final String restaurantName;

  const RestaurantDetailScreen({
    super.key,
    required this.restaurantId,
    required this.restaurantName,
  });

  Future restaurantProducts() async {
    final dio = Dio();

    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);

    final res = await dio.get(
      'http://$ip/restaurant/${restaurantId}',
      options: Options(
        headers: {'authorization': 'Bearer $accessToken'},
      ),
    );

    print(res.data);

    return res.data;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: restaurantName,
      child: FutureBuilder(
          future: restaurantProducts(),
          builder: (context, snapshot) {
            print(snapshot.error);
            if (!snapshot.hasData) {
              print('없음');
              return Container();
            }

            final detailRestaurant = snapshot.data!;

            return Column(
              children: [
                RestaurantCard(
                  image: Image.network(
                      'http://$ip${detailRestaurant['thumbUrl']}'),
                  name: detailRestaurant['name'],
                  tags: List.from(detailRestaurant['tags']),
                  ratingsCount: detailRestaurant['ratingsCount'],
                  deliveryTime: detailRestaurant['deliveryTime'],
                  deliveryFee: detailRestaurant['deliveryFee'],
                  ratings: detailRestaurant['ratings'],
                  isDetail: true,
                  detail: detailRestaurant['detail'],
                ),
                Column(
                  children: [],
                )
              ],
            );
          }),
    );
  }
}
