import 'package:flutter/material.dart';

import '../colors/colors.dart';
import '../textstyles/textstyles.dart';

class PasswordsLogAppBar extends PreferredSize {
  const PasswordsLogAppBar({
    super.key,
  }) : super(preferredSize: const Size.fromHeight(70), child: const Row());

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.chevron_left,
            color: kWhite,
            size: 40,
          )),
      backgroundColor: appBarBg,
      title: const Text(
        "Passwords Log",
        style: appBarTextStyle,
      ),
    );
  }
}
