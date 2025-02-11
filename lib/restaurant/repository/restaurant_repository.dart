import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/http.dart';
import 'package:section2/restaurant/model/restaurant_detail_model.dart';

part 'restaurant_repository.g.dart';

@RestApi()
abstract class RestaurantRepository {
  // http://$ip/restaurant
  factory RestaurantRepository(Dio dio, {String baseUrl}) =
      _RestaurantRepository;

  // @GET('/')
  // pagenate();

  @GET('/{id}')
  @Headers({
    'accessToken': 'true',
    'refreshToken': 'true',
  })
  Future<RestaurantDetailModel> getRestaurantDetail({
    @Path() required String id,
  });
}
