import 'package:flutter/material.dart';
import 'package:section2/common/component/custom__Elevated_button.dart';
import 'package:section2/common/component/custom_text_form_field.dart';
import 'package:section2/common/const/colors.dart';
import 'package:section2/common/layout/default_layout.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey();

    return DefaultLayout(
      child: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _Title(),
                SizedBox(height: 16),
                _SubTitle(),
                Image.asset(
                  'asset/img/misc/logo.png',
                  height: MediaQuery.of(context).size.width / 3 * 2,
                ),
                SizedBox(
                  height: 30,
                ),
                //입력 폼
                _form(
                  formKey: formKey,
                ),
                SizedBox(
                  height: 30,
                ),
                CustomElevatedButton(
                  onPressed: () {},
                  title: '로그인',
                ),
                SizedBox(
                  height: 8,
                ),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    foregroundColor: PRIMARY_COLOR,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: Text(
                    '회원가입',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
        ),
      ),
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

class _Title extends StatelessWidget {
  const _Title({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      '환영합니다!',
      style: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

class _SubTitle extends StatelessWidget {
  const _SubTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      '이메일과 비밀번호를 입력해서 로그인을 해주세요!\n오늘도 성공적인 주문이 되길:)',
      style: TextStyle(
        color: BODY_TEXT_COLOR,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
