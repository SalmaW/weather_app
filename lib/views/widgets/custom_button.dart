import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton(
      {super.key,
      required this.text,
      required this.onPressed,
      required this.backgroundColor,
      this.child,
      this.semanticLabel});

  final String text;
  final Color backgroundColor;
  final VoidCallback? onPressed;
  final Widget? child;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    double screenHeight = MediaQuery.sizeOf(context).height;
    double screenWidth = MediaQuery.sizeOf(context).width;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Semantics(
        button: true, // indicate en fy button
        label: semanticLabel ?? text,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            minimumSize: Size(screenWidth, screenHeight * 0.07),
            backgroundColor: backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: onPressed,
          child: child ??
              Text(text,
                  style: TextStyle(
                    fontSize: 16,
                    color: theme.textTheme.bodyLarge?.color,
                    fontWeight: FontWeight.w400,
                  )),
        ),
      ),
    );
  }
}
