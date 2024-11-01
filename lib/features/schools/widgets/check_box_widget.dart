import 'package:flutter/material.dart';

class CheckBoxWidget extends StatelessWidget {
  const CheckBoxWidget(
      {super.key,
      required this.title,
      required this.value,
      required this.onChange});
  final String title;
  final bool value;
  final ValueChanged<bool?>? onChange;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: value,
          onChanged: onChange,
        ),
        Text(title)
      ],
    );
  }
}
