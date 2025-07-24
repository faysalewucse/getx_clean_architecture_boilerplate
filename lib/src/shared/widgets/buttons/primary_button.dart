import 'package:flutter/material.dart';
import 'package:getx_clean_architecture_boilerplate/src/shared/widgets/loaders/primary_loader.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final double width;
  final double height;
  final bool loading;
  final bool disabled;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color borderColor;
  final double borderRadius;
  final double elevation;

  const PrimaryButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.width = double.infinity,
    this.backgroundColor,
    this.foregroundColor,
    this.borderRadius = 0,
    this.loading = false,
    this.disabled = false,
    this.borderColor = Colors.transparent,
    this.height = 44,
    this.elevation = 0,
  });

  @override
  Widget build(BuildContext context) {
    Color buttonBgColor = backgroundColor ?? Theme.of(context).primaryColor;

    return SizedBox(
      width: width,
      height: height,
      child: MaterialButton(
        elevation: elevation,
        onPressed: onPressed,
        color: buttonBgColor.withValues(alpha: loading || disabled ? 0.3 : 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          side: BorderSide(
            color: borderColor,
          ),
        ),
        padding: EdgeInsets.zero,
        minWidth: double.infinity,
        child: loading
            ? PrimaryLoader()
            : Text(
                label,
                style: TextStyle(
                  color: foregroundColor ?? Colors.white,
                  fontSize: 14,
                ),
              ),
      ),
    );
  }
}
