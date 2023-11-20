import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  const Avatar({
    required this.imagePath,
    required this.size,
    required this.action,
    super.key,
  });

  final String imagePath;
  final double size;
  final GestureTapCallback action;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: action,
      child: SizedBox(
        height: size,
        width: size,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(size / 2),
          child: Image.asset(imagePath),
        ),
      ),
    );
  }
}
