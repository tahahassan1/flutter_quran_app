import 'package:flutter/material.dart';

class FullImage extends StatelessWidget {
  const FullImage({
    super.key,
    required this.image,
  });
  final String image;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      image,
      fit: BoxFit.cover,
    );
  }
}
