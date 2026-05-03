import 'package:flutter/material.dart';
import 'package:scavium_wallet/app/theme/app_text_styles.dart';
import 'package:scavium_wallet/app/theme/tokens/scavo_tokens.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final String? subtitle;

  const SectionTitle({super.key, required this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyles.h1),
        if (subtitle != null) ...[
          const SizedBox(height: ScavoSpacing.xs),
          Text(subtitle!, style: AppTextStyles.bodyMuted),
        ],
      ],
    );
  }
}
