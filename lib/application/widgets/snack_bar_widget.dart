import 'package:flutter/material.dart';
import 'package:lovely_coffee/application/styles/color_styles.dart';
import 'package:lovely_coffee/application/styles/heading_styles.dart';

SnackBar snackBarWidget({
  required title,
  required icon,
  backgroundColor,
}) {
  return SnackBar(
    content: Row(
      children: [
        icon,
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            title,
            style: HeadingStyles.heading14Medium.copyWith(
              color: ColorStyles.heading3,
            ),
          ),
        ),
      ],
    ),
    backgroundColor: backgroundColor ?? ColorStyles.successSnackBar,
  );
}
