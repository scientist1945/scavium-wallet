import 'package:flutter/material.dart';

class ScaviumScaffold extends StatelessWidget {
  final Widget child;
  final PreferredSizeWidget? appBar;
  final bool useSafeArea;

  const ScaviumScaffold({
    super.key,
    required this.child,
    this.appBar,
    this.useSafeArea = true,
  });

  @override
  Widget build(BuildContext context) {
    final body = useSafeArea ? SafeArea(child: child) : child;

    return Scaffold(appBar: appBar, body: body);
  }
}
