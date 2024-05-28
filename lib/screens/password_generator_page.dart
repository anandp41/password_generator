import 'package:flutter/material.dart';
import '../colors/colors.dart';
import '../functions/custom_snackbar.dart';
import '../functions/process_password.dart';
import '../textstyles/textstyles.dart';
import '../widgets/copy_password_button.dart';
import '../widgets/custom_appbar_password_generator.dart';
import '../widgets/key_field.dart';
import '../widgets/length_row_and_field.dart';
import '../widgets/password_field.dart';

class PasswordGeneratorPage extends StatefulWidget {
  const PasswordGeneratorPage({
    super.key,
  });

  @override
  State<PasswordGeneratorPage> createState() => _PasswordGeneratorPageState();
}

class _PasswordGeneratorPageState extends State<PasswordGeneratorPage> {
  bool passwordVisible = false;
  bool oneSmallCaseLetter = false;
  bool oneUpperCaseLetter = false;
  bool oneNumber = false;
  bool oneSpecialCharacter = false;
  var passwordController = TextEditingController();
  var lengthController = TextEditingController();
  var keyNameController = TextEditingController();
  final clearButtonKey = GlobalKey();
  final copyPasswordButtonKey = GlobalKey();
  double clearButtonHeight = 0;
  double copyPasswordButtonHeight = 0;

  void onPasswordGeneration() {
    passwordVisible = true;
    keyNameController.clear();
    setState(() {});
  }

  void _createPassword({
    required int length,
    required bool oneSmallCaseLetter,
    required bool oneUpperCaseLetter,
    required bool oneNumber,
    required bool oneSpecialCharacter,
    required String key,
  }) {
    String password = processPassword(
        key: key,
        length: length,
        oneSmallCaseLetter: oneSmallCaseLetter,
        oneUpperCaseLetter: oneUpperCaseLetter,
        oneNumber: oneNumber,
        oneSpecialCharacter: oneSpecialCharacter);
    setState(() {
      passwordController.text = password;
    });
  }

  void clearConditions() {
    setState(() {
      passwordVisible = false;
      oneSmallCaseLetter = false;
      oneUpperCaseLetter = false;
      oneNumber = false;
      oneSpecialCharacter = false;
      passwordController.clear();
      lengthController.clear();
      keyNameController.clear();
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        clearButtonHeight = clearButtonKey.currentContext?.size?.height ?? 0;
        copyPasswordButtonHeight =
            copyPasswordButtonKey.currentContext?.size?.height ?? 0;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const PasswordGeneratorAppBar(),
      backgroundColor: bodyBg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                    alignment: Alignment.topRight,
                    child: passwordVisible
                        ? ElevatedButton.icon(
                            key: clearButtonKey,
                            style: const ButtonStyle(
                                backgroundColor: WidgetStateColor.transparent),
                            icon: const Icon(Icons.clear_all_outlined),
                            onPressed: clearConditions,
                            label: const Text(
                              "Clear all",
                              style: defaultTextStyle,
                            ))
                        : SizedBox(
                            height: clearButtonHeight,
                          )),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Form(
                        child: Column(
                      children: [
                        Row(
                          children: [
                            Checkbox.adaptive(
                                side: const BorderSide(
                                    color: checkboxColor, width: 2),
                                value: oneSmallCaseLetter,
                                onChanged: (value) {
                                  setState(() {
                                    oneSmallCaseLetter = value ?? false;
                                  });
                                }),
                            const Text(
                              "Small case letters",
                              style: defaultTextStyle,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Checkbox.adaptive(
                                side: const BorderSide(
                                    color: checkboxColor, width: 2),
                                value: oneUpperCaseLetter,
                                onChanged: (value) {
                                  setState(() {
                                    oneUpperCaseLetter = value ?? false;
                                  });
                                }),
                            const Text(
                              "Upper case letters",
                              style: defaultTextStyle,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Checkbox.adaptive(
                                side: const BorderSide(
                                    color: checkboxColor, width: 2),
                                value: oneNumber,
                                onChanged: (value) {
                                  setState(() {
                                    oneNumber = value ?? false;
                                  });
                                }),
                            const Text(
                              "Numbers",
                              style: defaultTextStyle,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Checkbox.adaptive(
                                side: const BorderSide(
                                    color: checkboxColor, width: 2),
                                value: oneSpecialCharacter,
                                onChanged: (value) {
                                  setState(() {
                                    oneSpecialCharacter = value ?? false;
                                  });
                                }),
                            const Text(
                              "Special characters",
                              style: defaultTextStyle,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    )),
                    LengthRowAndField(lengthController: lengthController),
                    const SizedBox(
                      height: 20,
                    ),
                    KeyField(keyNameController: keyNameController),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Password:',
                      style: defaultTextStyle,
                    ),
                    PasswordField(passwordController: passwordController),
                    const SizedBox(
                      height: 20,
                    ),
                    CopyPasswordButton(
                        passwordVisible: passwordVisible,
                        passwordController: passwordController,
                        copyPasswordButtonHeight: copyPasswordButtonHeight),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        enableFeedback: true,
        mini: false,
        onPressed: () {
          if (oneNumber ||
              oneSmallCaseLetter ||
              oneUpperCaseLetter ||
              oneSpecialCharacter) {
            int length = lengthController.text.isNotEmpty
                ? double.parse(lengthController.text).floor()
                : 6;
            String key = keyNameController.text.trim();
            _createPassword(
                length: length,
                key: key,
                oneSmallCaseLetter: oneSmallCaseLetter,
                oneUpperCaseLetter: oneUpperCaseLetter,
                oneNumber: oneNumber,
                oneSpecialCharacter: oneSpecialCharacter);
            onPasswordGeneration();
          } else {
            customSnackBar(
                text: "Check atleast one condition box", context: context);
          }
        },
        tooltip: 'Create',
        child: const Icon(
          Icons.handyman_outlined,
          size: 30,
        ),
      ),
    );
  }
}
