import 'package:flutter/material.dart';

class CustomFormTextField extends StatelessWidget {
  String? hintField;
  Function(String)? onChanged;
  bool? obscureText;

  CustomFormTextField(
      {super.key,
      required this.onChanged,
      this.hintField,
      this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: TextFormField(
        obscureText: obscureText!,
        validator: (data) {
          if (data!.isEmpty) {
            return 'Filed is Required';
          }
        },
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintField,
          hintStyle: const TextStyle(
            color: Colors.white,
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
        ),
      ),
    );
  }
}
