import 'package:flutter/material.dart';

class AppRadius {
  static const BorderRadius radius4 = BorderRadius.all(Radius.circular(4));
  static const BorderRadius radius6 = BorderRadius.all(Radius.circular(6));
  static const BorderRadius radius8 = BorderRadius.all(Radius.circular(8));
  static const BorderRadius radius10 = BorderRadius.all(Radius.circular(10));
  static const BorderRadius radius12 = BorderRadius.all(Radius.circular(12));
  static const BorderRadius radius16 = BorderRadius.all(Radius.circular(16));
  static const BorderRadius radius20 = BorderRadius.all(Radius.circular(20));
  static const BorderRadius radius30 = BorderRadius.all(Radius.circular(30));
  static const BorderRadius radiusCircle = BorderRadius.all(Radius.circular(9999));

  // Custom only-side radii
  static const BorderRadius topRadius10 = BorderRadius.vertical(top: Radius.circular(10));
  static const BorderRadius bottomRadius10 = BorderRadius.vertical(bottom: Radius.circular(10));
}
