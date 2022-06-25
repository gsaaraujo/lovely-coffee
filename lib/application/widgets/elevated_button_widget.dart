import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ElevatedButtonWidget extends StatelessWidget {
  const ElevatedButtonWidget({
    Key? key,
    required this.title,
    required this.onPressed,
    this.width,
    this.isLoading = false,
  }) : super(key: key);

  final String title;
  final bool isLoading;
  final double? width;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(width ?? double.infinity, 48.0),
      ),
      child: isLoading
          ? SpinKitThreeBounce(
              size: 28,
              itemBuilder: (BuildContext context, int index) {
                return DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: index.isEven
                        ? const Color(0XFFD17843)
                        : const Color(0XFF424242),
                  ),
                );
              },
            )
          : Text(title),
    );
  }
}
