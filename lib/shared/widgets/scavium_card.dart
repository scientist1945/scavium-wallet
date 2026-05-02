import 'package:flutter/material.dart';
import 'package:scavium_wallet/app/theme/tokens/scavo_tokens.dart';

class ScaviumCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;

  const ScaviumCard({super.key, required this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: padding ?? const EdgeInsets.all(ScavoSpacing.lg),
        child: child,
      ),
    );
  }
}
