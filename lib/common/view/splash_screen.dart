import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:section2/common/const/colors.dart';
import 'package:section2/common/const/data.dart';
import 'package:section2/common/dio/dio.dart';
import 'package:section2/common/layout/default_layout.dart';
import 'package:section2/common/view/root_tab.dart';
import 'package:section2/secure_storage/secure_storage_provider.dart';
import 'package:section2/user/view/login_screen.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // deleteToken();
    checkToken();
  }

  //토큰 검증
  void checkToken() async {
    final dio = Dio();
    final storage = ref.read(secureStorageStateProvider);

    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);

    try {
      final res = await dio.post(
        'http://$ip/auth/token',
        options: Options(headers: {'authorization': 'Bearer ${refreshToken}'}),
      );
      await storage.write(
          key: ACCESS_TOKEN_KEY, value: res.data['accessToken']);

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => const RootTab(),
        ),
        (route) => false,
      );
    } catch (e) {
      print('[Auth][Token] Error : $e');
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        ),
        (route) => false,
      );
    }
  }

  void deleteToken() async {
    final storage = ref.watch(secureStorageStateProvider);
    await storage.deleteAll();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      backgrounColor: PRIMARY_COLOR,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'asset/img/logo/logo.png',
              width: MediaQuery.of(context).size.width / 2,
            ),
            SizedBox(
              height: 16.0,
            ),
            CircularProgressIndicator(
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
