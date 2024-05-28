import 'package:flutter/material.dart';
import 'package:password_generator/screens/password_log.dart';
import '../colors/colors.dart';
import '../textstyles/textstyles.dart';

class PasswordGeneratorAppBar extends PreferredSize {
  const PasswordGeneratorAppBar({
    super.key,
  }) : super(preferredSize: const Size.fromHeight(70), child: const Row());

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: appBarBg,
      title: const Text(
        "Password Generator",
        style: appBarTextStyle,
      ),
      actions: [
        IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PasswordLog(),
                  ));
            },
            icon: const Icon(
              Icons.book,
              size: 54,
              color: passwordsLogBookColor,
            ))
      ],
    );
  }
}
