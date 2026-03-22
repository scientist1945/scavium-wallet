import 'package:flutter/material.dart';

class ScaviumLogo extends StatelessWidget {
  final double size;

  const ScaviumLogo({super.key, this.size = 72});

  static const String _assetPath = 'assets/branding/icon/scavium-icon.png';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Image.asset(
        _assetPath,
        fit: BoxFit.contain,
        filterQuality: FilterQuality.high,
      ),
    );
  }
}
