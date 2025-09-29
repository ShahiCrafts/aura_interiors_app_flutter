import 'package:flutter/material.dart';

Widget buildTextField({
  required String label,
  required String hint,
  required IconData icon,
  bool isPassword = false,
  bool isPasswordVisible = false,
  TextInputType? keyboardType,
  String? Function(String?)? validator,
  VoidCallback? onSuffixIconPressed,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: Colors.grey[800],
        ),
      ),
      const SizedBox(height: 6),
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey[40],
          border: Border.all(color: Colors.grey[300]!, width: 1),
        ),
        child: TextFormField(
          obscureText: isPassword && !isPasswordVisible,
          keyboardType: keyboardType,
          validator: validator,
          style: TextStyle(fontSize: 18, color: Colors.grey[800]),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey[600], fontSize: 18),
            prefixIcon: Icon(icon, color: Colors.grey[600], size: 20),
            suffixIcon: isPassword
                ? IconButton(
                    icon: Icon(
                      isPasswordVisible
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: Colors.grey[600],
                      size: 20,
                    ),
                    onPressed: onSuffixIconPressed,
                  )
                : null,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 15,
            ),
          ),
        ),
      ),
    ],
  );
}
