import 'package:flutter/material.dart';

class TextInputFieldWidget extends StatefulWidget {
  const TextInputFieldWidget({
    Key? key,
    required this.hint,
    required this.controller,
    this.textInputType,
    this.maxLength = 50,
    this.isPassword = false,
  }) : super(key: key);

  final TextEditingController controller;
  final TextInputType? textInputType;
  final int maxLength;
  final String hint;
  final bool isPassword;

  @override
  State<TextInputFieldWidget> createState() => _TextInputFieldWidgetState();
}

class _TextInputFieldWidgetState extends State<TextInputFieldWidget> {
  bool isPasswordHiden = true;
  bool hasText = false;

  @override
  void initState() {
    isPasswordHiden = !(widget.isPassword);

    widget.controller.addListener(() {
      widget.controller.text.isEmpty ? hasText = false : hasText = true;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: widget.maxLength,
      controller: widget.controller,
      keyboardType: widget.textInputType,
      decoration: InputDecoration(
        hintText: widget.hint,
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              widget.isPassword
                  ? isPasswordHiden = !isPasswordHiden
                  : widget.controller.clear();
            });
          },
          icon: Icon(
            widget.isPassword
                ? isPasswordHiden
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined
                : Icons.highlight_remove_rounded,
          ),
        ),
      ),
    );
  }
}
