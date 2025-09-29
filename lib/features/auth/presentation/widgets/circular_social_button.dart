import 'package:flutter/material.dart';

Widget buildCircularSocialButton({
  required VoidCallback onTap,
  required Widget icon,
}) {
  return Material(
    color: Colors.transparent,
    shape: const CircleBorder(),
    child: InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Ink(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          border: Border.all(color: const Color(0xFFE5E7EB), width: 1.5),
        ),
        child: Center(child: icon),
      ),
    ),
  );
}
