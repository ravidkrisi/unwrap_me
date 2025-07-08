import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String title;
  final double fontSize;
  final void Function()? onPressed;
  const MyButton({
    super.key,
    required this.title,
    required this.onPressed,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: Colors.amber.shade400,
          shadowColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.zero,
          ),
        ),
        child: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontSize),
        ),
      ),
    );
  }
}
