import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    required this.icon,
    this.onPressed,
  });

  final IconData icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      style: ButtonStyle(
        foregroundColor:
            WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return Colors.grey;
          }

          if (states.contains(WidgetState.pressed)) {
            return Colors.tealAccent;
          }

          return Colors.teal;
        }),
        side: WidgetStateProperty.resolveWith<BorderSide>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.disabled)) {
              return const BorderSide(
                color: Colors.grey,
              );
            }

            if (states.contains(WidgetState.pressed)) {
              return const BorderSide(
                color: Colors.tealAccent,
              );
            }

            return const BorderSide(
              color: Colors.teal,
              // width: 2.0
            );
          },
        ),
      ),
      icon: Icon(
        icon,
      ),
    );
  }
}
