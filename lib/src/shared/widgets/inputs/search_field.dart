import 'dart:async';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class SearchField extends StatefulWidget {
  final Future<void> Function(String query) onSearch;
  final String hintText;
  final Duration debounceDuration;
  final TextEditingController? controller;
  final Widget? prefixIcon;
  final bool autofocus;
  final FocusNode? focusNode;
  final VoidCallback? onClear;

  const SearchField({
    super.key,
    required this.onSearch,
    this.hintText = 'Search...',
    this.debounceDuration = const Duration(milliseconds: 500),
    this.controller,
    this.prefixIcon,
    this.autofocus = false,
    this.focusNode,
    this.onClear,
  });

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  late final TextEditingController _controller;
  Timer? _debounceTimer;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    if (widget.controller == null) _controller.dispose();
    super.dispose();
  }

  void _onChanged(String value) {
    _debounceTimer?.cancel();
    final query = value.trim();

    if (query.isEmpty) {
      setState(() => _isLoading = false);
      widget.onSearch(query);
      return;
    }

    setState(() => _isLoading = true);

    _debounceTimer = Timer(widget.debounceDuration, () async {
      try {
        await widget.onSearch(query);
      } finally {
        if (mounted) setState(() => _isLoading = false);
      }
    });
  }

  void _onClear() {
    _debounceTimer?.cancel();
    _controller.clear();
    setState(() => _isLoading = false);
    widget.onSearch('');
    widget.onClear?.call();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      focusNode: widget.focusNode,
      autofocus: widget.autofocus,
      onChanged: _onChanged,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        hintText: widget.hintText,
        prefixIcon: widget.prefixIcon ??
            const Icon(PhosphorIconsRegular.magnifyingGlass, size: 22),
        suffixIcon: _buildSuffix(),
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
          borderSide:
              BorderSide(color: Colors.grey.withValues(alpha: 0.2), width: 1),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      ),
    );
  }

  Widget? _buildSuffix() {
    if (_isLoading) {
      return const Padding(
        padding: EdgeInsets.all(10),
        child: SizedBox(
          width: 18,
          height: 18,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      );
    }

    if (_controller.text.isNotEmpty) {
      return IconButton(
        icon: const Icon(PhosphorIconsRegular.x, size: 18),
        onPressed: _onClear,
      );
    }

    return null;
  }
}
