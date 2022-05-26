import 'package:flutter/services.dart';

class PlateInputFormatter extends TextInputFormatter {
  final int maxLength = 8;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final newValueLength = newValue.text.length;
    var selectionIndex = newValue.selection.end;
    var substrIndex = 0;
    final newText = StringBuffer();

    if (newValueLength > maxLength) {
      return oldValue;
    }

    if (newValueLength == 4) {
      if (newValue.text.contains("-")) {
        newText.write(newValue.text.substring(0, substrIndex = 3));
      } else {
        newText.write(newValue.text.substring(0, substrIndex = 3) +
            '-' +
            newValue.text.substring(3, substrIndex = newValueLength));
        selectionIndex++;
      }
    }

    if (newValueLength >= substrIndex) {
      newText.write(newValue.text.substring(substrIndex));
    }

    return TextEditingValue(
      text: newText.toString().toUpperCase(),
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
