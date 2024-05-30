import 'package:flutter/material.dart';

TextField formBarang(TextEditingController controller, String labelText,
    String hintText, String? errorText, {TextInputType? keyboardType}) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(
      border: const OutlineInputBorder(),
      labelText: labelText,
      hintText: hintText,
      errorText: errorText,
    ),
    keyboardType: keyboardType,
  );
}

Widget showData(String title, String value) {
  return Row(
    children: [
      Text(
        title,
        style: const TextStyle(
          color: Colors.purple,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 30),
        child: Text(
          value,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    ],
  );
}
