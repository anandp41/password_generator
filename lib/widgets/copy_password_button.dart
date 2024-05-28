import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../functions/custom_snackbar.dart';
import '../textstyles/textstyles.dart';

class CopyPasswordButton extends StatelessWidget {
  const CopyPasswordButton({
    super.key,
    required this.passwordVisible,
    required this.passwordController,
    required this.copyPasswordButtonHeight,
  });

  final bool passwordVisible;
  final TextEditingController passwordController;
  final double copyPasswordButtonHeight;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: passwordVisible
          ? ElevatedButton.icon(
              icon: const Icon(Icons.copy_outlined),
              style: const ButtonStyle(
                  backgroundColor: WidgetStateColor.transparent),
              onPressed: () async {
                await Clipboard.setData(
                    ClipboardData(text: passwordController.text));
                customSnackBar(
                    text: "Password copied to clipboard!",
                    // ignore: use_build_context_synchronously
                    context: context);
              },
              label: const Text(
                'Copy Password',
                style: defaultTextStyle,
              ))
          : SizedBox(
              height: copyPasswordButtonHeight,
            ),
    );
  }
}
