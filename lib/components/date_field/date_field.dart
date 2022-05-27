import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:nice_parking/utils/consts.dart';

class CustomDateField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String? Function(DateTime?)? validator;
  const CustomDateField(
      {required this.validator,
      required this.label,
      required this.controller,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final format = DateFormat("dd/MM/yyyy");
    return DateTimeField(
      validator: validator!,
      format: format,
      controller: controller,
      style: GoogleFonts.play(color: Colors.white, fontSize: 24),
      decoration: InputDecoration(
        fillColor: customBlack,
        filled: true,
        labelText: label,
        labelStyle: GoogleFonts.lato(
            color: Colors.white.withOpacity(0.5), fontSize: 18),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: greenPrimary1),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: greenPrimary1),
        ),
      ),
      onShowPicker: (context, currentValue) async {
        return await showDatePicker(
          context: context,
          firstDate: DateTime(1900),
          initialDate: currentValue ?? DateTime.now(),
          lastDate: DateTime(2100),
          builder: (BuildContext context, Widget? child) {
            return Theme(
              data: ThemeData.dark().copyWith(
                colorScheme: const ColorScheme.dark(
                  primary: greenPrimary1,
                  onPrimary: Colors.white,
                  surface: black2,
                  onSurface: Colors.white,
                ),
                dialogBackgroundColor: customBlack,
              ),
              child: child!,
            );
          },
        );
      },
    );
  }
}
