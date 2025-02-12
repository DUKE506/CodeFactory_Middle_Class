import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:section2/common/const/data.dart';
import 'package:section2/secure_storage/secure_storage_provider.dart';

part 'dio.g.dart';

@riverpod
Dio dioState(ref) {
  final dio = Dio();

  final storage = ref.watch(secureStorageStateProvider);

  dio.interceptors.add(CustomInterceptor(storage: storage));

  return dio;
}

class CustomInterceptor extends Interceptor {
  final FlutterSecureStorage storage;

  CustomInterceptor({
    required this.storage,
  });

  /// 1) 요청 보낼 때
  /// 요청이 보내질때마다
  /// 만약에 요청의 Headers에 accessToken이 true 이면
  /// 실제 토큰을 가져와서 기존 accessToken값을 삭제하고 {
  /// authorization : Beader $토큰} 값을 추가
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    print('[REQ] [${options.method}] ${options.uri}');

    if (options.headers['accessToken'] == 'true') {
      options.headers.remove('accessToken');

      final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
      options.headers.addAll(
        {'authorization': 'Bearer $accessToken'},
      );
    }

    if (options.headers['refreshToken'] == 'true') {
      options.headers.remove('refreshToken');

      final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);
      options.headers.addAll(
        {'authorization': 'Bearer $refreshToken'},
      );
    }

    return super.onRequest(options, handler);
  }

  /// 2) 응답 받을 때
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(
        '[RES] [${response.requestOptions.method}] ${response.requestOptions.uri}');

    super.onResponse(response, handler);
  }

  /// 3) 에러 났을 때
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // 401에러 났을 때 (status code)
    // 토큰을 재발급 받는 시도를하고 토큰이 재발급되면
    // 다시 새로운 토큰을 요청한다.

    print('[ERROR] [${err.requestOptions.method}] ${err.requestOptions.uri}');
    print('[ERROR] [MESSAGE] ${err.message}');

    // refreshToken이 없는 경우
    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);
    if (refreshToken == null) {
      // 에러 던질때는 handler.reject()사용

      return handler.reject(err);
    }

    final isStatus401 = err.response?.statusCode == 401;
    final isPathRefresh = err.requestOptions.path == '/auth/token';

    if (isStatus401 && !isPathRefresh) {
      final dio = Dio();

      try {
        final res = await dio.post(
          'http://$ip/auth/token',
          options: Options(
            headers: {
              'authorization': 'Bearer $refreshToken',
            },
          ),
        );

        final accessToken = res.data['accessToken'];

        final options = err.requestOptions;

        //기존 토큰 변경
        options.headers.addAll({
          'authorization': 'Bearer $accessToken',
        });

        await storage.write(key: ACCESS_TOKEN_KEY, value: accessToken);

        // 에러난 요청options에 토큰값을 신규로 변경하여 재전송
        final resending = await dio.fetch(options);

        return handler.resolve(resending);
      } on DioException catch (e) {
        return handler.reject(e);
      }
    }

    return handler.reject(err);
  }
}
