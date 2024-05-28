import 'package:flutter/material.dart';

import '../textstyles/textstyles.dart';

class KeyField extends StatelessWidget {
  const KeyField({
    super.key,
    required this.keyNameController,
  });

  final TextEditingController keyNameController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          'Key:',
          style: defaultTextStyle,
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: TextFormField(
            style: const TextStyle(fontSize: 20, color: Colors.white),
            controller: keyNameController,
            decoration: const InputDecoration(
                hintText: '(Optional) What is this password for ?',
                hintStyle: TextStyle(color: Colors.white24, fontSize: 15),
                border: OutlineInputBorder(borderSide: BorderSide(width: 2))),
          ),
        ),
      ],
    );
  }
}
