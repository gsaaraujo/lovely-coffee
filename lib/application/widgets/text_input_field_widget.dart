import 'package:flutter/material.dart';
import 'package:lovely_coffee/application/styles/heading_styles.dart';

class TextInputFieldWidget extends StatefulWidget {
  const TextInputFieldWidget({
    Key? key,
    required this.hint,
    required this.controller,
    this.validator,
    this.textInputType,
    this.maxLength = 50,
    this.isPassword = false,
  }) : super(key: key);

  final String hint;
  final int maxLength;
  final bool isPassword;
  final TextInputType? textInputType;
  final TextEditingController controller;
  final Function(String)? validator;

  @override
  State<TextInputFieldWidget> createState() => _TextInputFieldWidgetState();
}

class _TextInputFieldWidgetState extends State<TextInputFieldWidget> {
  bool hasText = false;
  bool isPasswordHiden = false;

  @override
  void initState() {
    isPasswordHiden = widget.isPassword;

    widget.controller.addListener(() {
      setState(() {
        widget.controller.text.isEmpty ? hasText = false : hasText = true;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: widget.maxLength,
      obscureText: isPasswordHiden,
      controller: widget.controller,
      keyboardType: widget.textInputType,
      style: HeadingStyles.heading14Normal,
      decoration: InputDecoration(
        counterText: '',
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
                : hasText
                    ? Icons.highlight_remove_rounded
                    : null,
          ),
        ),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'This field is required';
        }

        if (widget.validator != null) {
          return widget.validator!(value);
        }

        return null;
      },
    );
  }
}
