import 'package:flutter/material.dart';
import 'package:section2/common/component/custom_text_form_field.dart';
import 'package:section2/common/const/colors.dart';
import 'package:section2/common/layout/default_layout.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey();

    return DefaultLayout(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _banner(),
              //입력 폼
              _form(
                formKey: formKey,
              )
            ],
          ),
        ),
      ),
    );
  }

  //배너
  Widget _banner() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '환영합니다!',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          '이메일과 비밀번호를 입력해서 로그인을 해주세요!\n오늘도 성공적인 주문이 되길:)',
          style: TextStyle(
            color: BODY_TEXT_COLOR,
            fontWeight: FontWeight.w700,
          ),
        ),
        Center(
          child: Image.asset(
            'asset/img/misc/logo.png',
            height: 250,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }

  //입력폼
  Widget _form({
    required GlobalKey<FormState> formKey,
  }) {
    return Form(
      child: Column(
        children: [
          CustomTextFormField(
            hintText: '이메일을 입력해주세요',
            onChanged: (value) {
              print('이메일 : $value');
            },
          ),
          const SizedBox(
            height: 8,
          ),
          CustomTextFormField(
            hintText: '비밀번호를 입력해주세요',
            obscureText: true,
            onChanged: (value) {
              print('비밀번호 : $value');
            },
          ),
        ],
      ),
    );
  }
}
