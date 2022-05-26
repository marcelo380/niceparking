import 'package:flutter/material.dart';
import 'package:nice_parking/components/typography/typography.dart';
import 'package:nice_parking/utils/consts.dart';

class ContainedButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color overideColor;
  const ContainedButton(
      {required this.label,
      required this.onPressed,
      this.overideColor = greenPrimary1,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(overideColor),
      ),
      onPressed: onPressed,
      child: CustomTypography.title16(label, color: blackText),
    );
  }
}
