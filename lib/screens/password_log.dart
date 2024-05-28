import 'package:flutter/material.dart';
import 'package:password_generator/db/functions/db_functions.dart';

import '../colors/colors.dart';
import '../widgets/custom_appbar_passwords_log.dart';
import '../widgets/passwords_log_tile.dart';

List<Map<String, Object?>> dataListMap = [];

class PasswordLog extends StatelessWidget {
  const PasswordLog({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PasswordsLogAppBar(),
      backgroundColor: bodyBg,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ValueListenableBuilder(
          valueListenable: passwordLogNotifier,
          builder: (context, passwordList, child) {
            dataListMap.clear();
            return ListView.separated(
                itemBuilder: (ctx, index) {
                  final data = passwordList[index];
                  dataListMap.add({'key': data.key, 'password': data.password});
                  return Card(
                    color: passwordLogTileBg,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25))),
                    child: PasswordsLogTile(data: data),
                  );
                },
                separatorBuilder: (ctx, index) {
                  return const Divider(
                    color: passwordLogDividerColor,
                  );
                },
                itemCount: passwordList.length);
          },
        ),
      )),
    );
  }
}
