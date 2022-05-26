import 'package:flutter/material.dart';
import 'package:nice_parking/components/typography/typography.dart';
import 'package:nice_parking/utils/consts.dart';

class ContainedButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  const ContainedButton(
      {required this.label, required this.onPressed, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(greenPrimary1),
      ),
      onPressed: onPressed,
      child: CustomTypography.title16(label, color: blackText),
    );
  }
}
