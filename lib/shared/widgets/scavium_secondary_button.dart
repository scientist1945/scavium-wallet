import 'package:flutter/material.dart';
import 'package:scavium_wallet/app/theme/app_colors.dart';
import 'package:scavium_wallet/app/theme/app_text_styles.dart';

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
      height: 54,
      width: double.infinity,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: AppColors.border),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        onPressed: onPressed,
        child: Text(text, style: AppTextStyles.button),
      ),
    );
  }
}
