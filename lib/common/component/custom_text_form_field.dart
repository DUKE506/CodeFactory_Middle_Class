import 'package:flutter/material.dart';
import 'package:section2/common/const/colors.dart';

class CustomTextFormField extends StatelessWidget {
  final bool obscureText;
  final bool autofocus;
  final ValueChanged<String>? onChanged;
  final String? hintText;
  final String? errorText;
  const CustomTextFormField({
    super.key,
    this.obscureText = false,
    this.autofocus = false,
    required this.onChanged,
    this.hintText,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    final baseBorder = OutlineInputBorder(
        borderSide: BorderSide(
      color: INPUT_BORDER_COLOR,
      width: 1,
    ));

    return TextFormField(
      cursorColor: PRIMARY_COLOR,
      //비밀번호 입력할 때 블라인드 처리
      obscureText: obscureText,
      autofocus: autofocus,
      //값이 바뀔 때 마다 실행
      onChanged: onChanged,
      decoration: InputDecoration(
        contentPadding: const EdgeInsetsDirectional.all(20.0),
        hintText: hintText,
        hintStyle: const TextStyle(
          color: BODY_TEXT_COLOR,
          fontSize: 14.0,
        ),
        errorText: errorText,
        fillColor: INPUT_BG_COLOR,
        filled: true,
        //모든 INPUT 상태의 기본 스타일 세팅
        //(다양한 상태 존재 / 비활성화 / 활성화focus 등)
        border: baseBorder,
        focusedBorder: baseBorder.copyWith(
            borderSide: baseBorder.borderSide.copyWith(
          color: PRIMARY_COLOR,
        )),
      ),
    );
  }
}
