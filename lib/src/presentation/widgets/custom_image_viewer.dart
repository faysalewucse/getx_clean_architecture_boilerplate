import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CustomImageViewer extends StatelessWidget {
  final String imageUrl;
  final BoxFit? fit;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final Widget? placeholder;
  final Widget? errorWidget;
  final Color? placeholderColor;
  final IconData? errorIcon;
  final Color? errorIconColor;
  final Duration? fadeInDuration;
  final Duration? placeholderFadeInDuration;

  const CustomImageViewer({
    super.key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.borderRadius,
    this.placeholder,
    this.errorWidget,
    this.placeholderColor,
    this.errorIcon = Icons.broken_image,
    this.errorIconColor,
    this.fadeInDuration = const Duration(milliseconds: 300),
    this.placeholderFadeInDuration = const Duration(milliseconds: 200),
  });

  @override
  Widget build(BuildContext context) {
    Widget imageWidget = CachedNetworkImage(
      imageUrl: imageUrl,
      fit: fit,
      width: width,
      height: height,
      fadeInDuration: fadeInDuration ?? const Duration(milliseconds: 300),
      placeholderFadeInDuration: placeholderFadeInDuration ?? const Duration(milliseconds: 200),
      placeholder: (context, url) =>
          placeholder ?? _buildDefaultPlaceholder(context),
      errorWidget: (context, url, error) =>
          errorWidget ?? _buildDefaultErrorWidget(context),
    );

    if (borderRadius != null) {
      return ClipRRect(
        borderRadius: borderRadius!,
        child: imageWidget,
      );
    }

    return imageWidget;
  }

  Widget _buildDefaultPlaceholder(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: placeholderColor ?? Colors.grey[100],
      child: const Center(
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
        ),
      ),
    );
  }

  Widget _buildDefaultErrorWidget(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: placeholderColor ?? Colors.grey[100],
      child: Center(
        child: Icon(
          errorIcon,
          color: errorIconColor ?? Colors.grey[400],
          size: width != null && height != null
              ? (width! < height! ? width! * 0.3 : height! * 0.3)
              : 32,
        ),
      ),
    );
  }

  // Factory constructors for common use cases

  /// Creates a circular avatar image
  factory CustomImageViewer.avatar({
    required String imageUrl,
    required double radius,
    Color? placeholderColor,
    IconData? errorIcon = Icons.person,
    Color? errorIconColor,
  }) {
    return CustomImageViewer(
      imageUrl: imageUrl,
      width: radius * 2,
      height: radius * 2,
      borderRadius: BorderRadius.circular(radius),
      fit: BoxFit.cover,
      placeholderColor: placeholderColor,
      errorIcon: errorIcon,
      errorIconColor: errorIconColor,
    );
  }

  /// Creates a card-style image with rounded corners
  factory CustomImageViewer.card({
    required String imageUrl,
    double? width,
    double? height,
    double borderRadius = 12,
    BoxFit? fit = BoxFit.cover,
    Color? placeholderColor,
  }) {
    return CustomImageViewer(
      imageUrl: imageUrl,
      width: width,
      height: height,
      borderRadius: BorderRadius.circular(borderRadius),
      fit: fit,
      placeholderColor: placeholderColor,
    );
  }

  /// Creates a thumbnail image
  factory CustomImageViewer.thumbnail({
    required String imageUrl,
    double size = 50,
    double borderRadius = 8,
    Color? placeholderColor,
  }) {
    return CustomImageViewer(
      imageUrl: imageUrl,
      width: size,
      height: size,
      borderRadius: BorderRadius.circular(borderRadius),
      fit: BoxFit.cover,
      placeholderColor: placeholderColor,
    );
  }

  /// Creates a banner/header image
  factory CustomImageViewer.banner({
    required String imageUrl,
    double? width,
    double height = 200,
    BorderRadius? borderRadius,
    Color? placeholderColor,
  }) {
    return CustomImageViewer(
      imageUrl: imageUrl,
      width: width ?? double.infinity,
      height: height,
      borderRadius: borderRadius,
      fit: BoxFit.cover,
      placeholderColor: placeholderColor,
    );
  }
}