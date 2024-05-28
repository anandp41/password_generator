import 'package:flutter/material.dart';

import '../textstyles/textstyles.dart';

class LengthRowAndField extends StatelessWidget {
  const LengthRowAndField({
    super.key,
    required this.lengthController,
  });

  final TextEditingController lengthController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          'Length:',
          style: defaultTextStyle,
        ),
        const SizedBox(
          width: 20,
        ),
        SizedBox(
          width: 160,
          child: TextFormField(
            style: const TextStyle(fontSize: 20, color: Colors.white),
            controller: lengthController,
            keyboardType: const TextInputType.numberWithOptions(
                decimal: false, signed: false),
            decoration: const InputDecoration(
                hintText: '(Optional) 6-20',
                hintStyle: TextStyle(color: Colors.white24, fontSize: 16),
                border: OutlineInputBorder(borderSide: BorderSide(width: 2))),
          ),
        ),
      ],
    );
  }
}
