import 'package:flutter/material.dart';
import 'package:section2/common/const/colors.dart';

class CustomElevatedButton extends StatelessWidget {
  final Color? color;
  final VoidCallback onPressed;
  final String title;
  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.title,
    this.color = PRIMARY_COLOR,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        title,
        style: TextStyle(
          color: color == Color(0xFF22A45D) ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
