import 'package:flutter/material.dart';

String? message;
void showSnackBar(BuildContext context, message) async {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}