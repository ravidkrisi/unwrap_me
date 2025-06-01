import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String title;
  final void Function()? onPressed;
  const MyButton({super.key, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(shadowColor: Colors.white),
        child: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}
