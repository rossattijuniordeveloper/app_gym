import 'package:flutter/material.dart';

InputDecoration getLoginInputDecoration(
    String label, IconData? icone, double fontSize, Color cor) {
  return InputDecoration(
    suffixIcon: Icon(icone),
    label: Text(
      label,
      style: TextStyle(
        fontSize: fontSize,
        color: cor,
      ),
    ),
    fillColor: Colors.grey,
    filled: true,
    hintText: label,

    contentPadding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
    // bprda do Inputs
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(64),
    ),
    //borda dos inputs quando habilitados sem foco
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(64),
      borderSide: const BorderSide(
        color: Colors.black,
        width: 2,
      ),
    ),
    //borda do input quando em foco
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(64),
      borderSide: const BorderSide(
        color: Colors.white,
        width: 4,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(64),
      borderSide: const BorderSide(
        color: Colors.red,
        width: 2,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(64),
      borderSide: const BorderSide(
        color: Colors.red,
        width: 4,
      ),
    ),
  );
}
