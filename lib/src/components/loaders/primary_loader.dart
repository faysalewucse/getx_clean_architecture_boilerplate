import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class PrimaryLoader extends StatelessWidget {
  final double size;
  const PrimaryLoader({super.key, this.size = 30});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      child: SpinKitFadingCircle(
        color: Colors.white,
        size: size,
      ),
    );
  }
}
