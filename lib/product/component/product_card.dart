import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final Image image;
  final String name;
  final String explanation;

  const ProductCard({
    super.key,
    required this.image,
    required this.name,
    required this.explanation,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        image,
        Column(
          children: [
            Text(name),
            Text(explanation),
          ],
        ),
      ],
    );
  }
}
