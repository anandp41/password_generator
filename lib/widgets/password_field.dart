import 'package:flutter/material.dart';

class PasswordField extends StatelessWidget {
  const PasswordField({
    super.key,
    required this.passwordController,
  });

  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
          border: OutlineInputBorder(borderSide: BorderSide(width: 2))),
      controller: passwordController,
      readOnly: true,
      canRequestFocus: false,
      style: const TextStyle(color: Colors.white, fontSize: 20),
    );
  }
}
