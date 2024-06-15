import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  const CustomTextField({super.key,required this.controller,this.hintText});

  @override
  Widget build(BuildContext context) {
    return  TextField(
      controller: controller,
      decoration:  InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        filled: true,
        hintText: hintText
      ),
    );
  }
}