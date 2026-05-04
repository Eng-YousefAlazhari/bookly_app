import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          hintText: 'search',
          prefixIcon: const Icon(
            FontAwesomeIcons.magnifyingGlass,
            color: Color.fromARGB(120, 255, 255, 255),
          ),
          enabledBorder: buildOutlineInputBorder(),
          focusedBorder: buildOutlineInputBorder(Colors.white)),
    );
  }
}

OutlineInputBorder buildOutlineInputBorder([color]) {
  return OutlineInputBorder(
    borderSide: BorderSide(color: color ?? Colors.grey),
    borderRadius: BorderRadius.circular(12),
  );
}
