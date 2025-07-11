import 'package:flutter/material.dart';

enum ButtonType { filled, outlined, text }

class Button extends StatelessWidget {
  const Button({
    super.key,
    required this.child,
    this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.width,
    this.height,
    this.borderRadius = 12.0,
    this.isDisabled = false,
    this.buttonType = ButtonType.filled,
  });

  final Widget child;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final double? height;
  final double borderRadius;
  final bool isDisabled;
  final ButtonType buttonType;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveOnPressed = isDisabled ? null : onPressed;

    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(borderRadius),
    );

    final buttonStyle = _buildStyle(theme, shape);

    Widget button;

    switch (buttonType) {
      case ButtonType.filled:
        button = ElevatedButton(
          onPressed: effectiveOnPressed,
          style: buttonStyle,
          child: child,
        );
        break;
      case ButtonType.outlined:
        button = OutlinedButton(
          onPressed: effectiveOnPressed,
          style: buttonStyle,
          child: child,
        );
        break;
      case ButtonType.text:
        button = TextButton(
          onPressed: effectiveOnPressed,
          style: buttonStyle,
          child: child,
        );
        break;
    }

    return SizedBox(width: width, height: height ?? 48, child: button);
  }

  ButtonStyle _buildStyle(ThemeData theme, RoundedRectangleBorder shape) {
    switch (buttonType) {
      case ButtonType.filled:
        return ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? theme.colorScheme.primary,
          foregroundColor: textColor ?? theme.colorScheme.onPrimary,
          shape: shape,
        );
      case ButtonType.outlined:
        return OutlinedButton.styleFrom(
          foregroundColor: textColor ?? theme.colorScheme.primary,
          backgroundColor: backgroundColor,
          shape: shape,
          side: BorderSide(color: theme.colorScheme.primary),
        );
      case ButtonType.text:
        return TextButton.styleFrom(
          foregroundColor: textColor ?? theme.colorScheme.primary,
          shape: shape,
          backgroundColor: backgroundColor,
        );
    }
  }
}
