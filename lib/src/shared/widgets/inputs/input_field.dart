import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class InputField extends StatefulWidget {
  final String? label;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool obscureText;
  final bool hintTextAsLabel;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? hintText;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final bool enabled;
  final int? maxLines;
  final int? minLines;
  final FocusNode? focusNode;
  final bool isPassword; // New parameter to enable password toggle
  final Iterable<String>? autofillHints; // Autofill hints for credential manager

  const InputField({
    super.key,
    this.label,
    this.controller,
    this.validator,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.prefixIcon,
    this.suffixIcon,
    this.hintText,
    this.onChanged,
    this.onFieldSubmitted,
    this.enabled = true,
    this.maxLines = 1,
    this.minLines,
    this.focusNode,
    this.hintTextAsLabel = true,
    this.isPassword = false,
    this.autofillHints,
  });

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Determine suffix icon - use password toggle if isPassword, otherwise use provided suffixIcon
    Widget? effectiveSuffixIcon = widget.suffixIcon;
    if (widget.isPassword) {
      effectiveSuffixIcon = IconButton(
        icon: Icon(
          _obscureText
              ? PhosphorIconsRegular.eyeSlash
              : PhosphorIconsRegular.eye,
          color: Colors.grey[600],
        ),
        onPressed: _togglePasswordVisibility,
      );
    }

    final input = TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      obscureText: _obscureText,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      autofillHints: widget.autofillHints,
      decoration: InputFieldDecoration.inputDecoration(
        label: widget.hintTextAsLabel ? widget.hintText : null,
        prefixIcon: widget.prefixIcon,
        suffixIcon: effectiveSuffixIcon,
      ),
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onFieldSubmitted,
      enabled: widget.enabled,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      focusNode: widget.focusNode,
    );

    if (widget.label != null && widget.label!.isNotEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.label!, style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 8),
          input,
        ],
      );
    }
    return input;
  }
}


class InputFieldDecoration {
  static InputDecoration inputDecoration({
    String? label,
    String? hintText,
    Widget? prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hintText,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: Colors.grey.withValues(alpha: 0.05),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.blue, width: 2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.withValues(alpha: 0.2), width: 1),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    );
  }
}
