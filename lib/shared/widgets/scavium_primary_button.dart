import 'package:flutter/material.dart';
import 'package:scavium_wallet/app/theme/app_text_styles.dart';
import 'package:scavium_wallet/app/theme/tokens/scavo_tokens.dart';

class ScaviumPrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;

  const ScaviumPrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ScavoSpacing.section + ScavoSpacing.sm + ScavoSpacing.xxs / 2,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        child:
            isLoading
                ? const SizedBox(
                  width: ScavoSpacing.lg - ScavoSpacing.xxs / 2,
                  height: ScavoSpacing.lg - ScavoSpacing.xxs / 2,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
                : Text(text, style: AppTextStyles.button),
      ),
    );
  }
}
