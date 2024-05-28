import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../colors/colors.dart';
import '../db/functions/db_functions.dart';
import '../db/model/data_model.dart';
import '../functions/custom_snackbar.dart';
import '../textstyles/textstyles.dart';

class PasswordsLogTile extends StatelessWidget {
  const PasswordsLogTile({
    super.key,
    required this.data,
  });

  final PasswordModel data;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 12),
      title: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Key: ${data.key}",
                  style: defaultTextStyle,
                ),
                const Divider(
                  height: 0,
                ),
                Text(
                  "Password: ${data.password}",
                  style: defaultTextStyle,
                )
              ],
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                  onPressed: () async {
                    await Clipboard.setData(ClipboardData(text: data.password));
                    customSnackBar(
                        text: "Password copied to clipboard!",
                        // ignore: use_build_context_synchronously
                        context: context);
                  },
                  icon: Icon(
                    Icons.copy_outlined,
                    color: passwordsLogTileCopyIconColor,
                  )),
              IconButton(
                  onPressed: () async {
                    await deleteRow(context, data.key);
                  },
                  icon: Icon(
                    Icons.delete_outline,
                    color: passwordLogDeleteButtonColor,
                  )),
            ],
          )
        ],
      ),
    );
  }
}
