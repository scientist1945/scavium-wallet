import 'package:flutter/material.dart';

class ScaviumCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;

  const ScaviumCard({super.key, required this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: padding ?? const EdgeInsets.all(20),
        child: child,
      ),
    );
  }
}
