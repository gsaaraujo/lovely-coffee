// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    Key? key,
    required this.hint,
    required this.onSearch,
    required this.controller,
    this.maxLength = 50,
  }) : super(key: key);

  final String hint;
  final int maxLength;
  final VoidCallback onSearch;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        counterText: '',
        hintText: hint,
        suffixIcon: IconButton(
          onPressed: onSearch,
          icon: const Icon(Icons.search),
        ),
      ),
    );
  }
}
