import 'package:flutter/material.dart';
import 'package:scavium_wallet/app/theme/tokens/scavo_tokens.dart';

class ScaviumSecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const ScaviumSecondaryButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ScavoSpacing.section + ScavoSpacing.sm + ScavoSpacing.xxs / 2,
      width: double.infinity,
      child: OutlinedButton(onPressed: onPressed, child: Text(text)),
    );
  }
}
