import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nice_parking/utils/consts.dart';
import 'package:nice_parking/utils/formatters/plate_formatter.dart';

class CustomPlateTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  const CustomPlateTextField({required this.textEditingController, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // controller: passTextController,
      inputFormatters: [
        PlateInputFormatter(),
      ],
      textAlign: TextAlign.center,
      style: GoogleFonts.play(color: Colors.white, fontSize: 24),
      decoration: InputDecoration(
        fillColor: customBlack,
        filled: true,
        labelText: "Placa do veículo",
        labelStyle: GoogleFonts.lato(
            color: Colors.white.withOpacity(0.5), fontSize: 18),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: greenPrimary1),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: greenPrimary1),
        ),
      ),
      keyboardType: TextInputType.text,
    );
  }
}
