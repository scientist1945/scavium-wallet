import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:scavium_wallet/app/router/route_names.dart';
import 'package:scavium_wallet/core/security/screenshot_guard.dart';
import 'package:scavium_wallet/features/lock/application/app_lock_state_controller.dart';
import 'package:scavium_wallet/features/wallet/application/wallet_controller.dart';
import 'package:scavium_wallet/shared/widgets/scavium_card.dart';
import 'package:scavium_wallet/shared/widgets/scavium_primary_button.dart';
import 'package:scavium_wallet/shared/widgets/scavium_scaffold.dart';
import 'package:scavium_wallet/shared/widgets/section_title.dart';

class ConfirmMnemonicScreen extends ConsumerStatefulWidget {
  const ConfirmMnemonicScreen({super.key});

  @override
  ConsumerState<ConfirmMnemonicScreen> createState() =>
      _ConfirmMnemonicScreenState();
}

class _ConfirmMnemonicScreenState extends ConsumerState<ConfirmMnemonicScreen> {
  final _controllers = <TextEditingController>[];
  List<int> _positions = [];
  List<String> _mnemonicWords = [];
  String? _error;

  @override
  void initState() {
    super.initState();
    ScreenshotGuard.enableProtection();
    _prepare();
  }

  Future<void> _prepare() async {
    final mnemonic =
        await ref.read(walletControllerProvider.notifier).readMnemonic();

    if (mnemonic == null || mnemonic.trim().isEmpty) {
      setState(() {
        _error = 'No mnemonic available';
      });
      return;
    }

    final words = mnemonic.split(' ');
    final random = Random();
    final selected = <int>{};

    while (selected.length < 3 && selected.length < words.length) {
      selected.add(random.nextInt(words.length));
    }

    _mnemonicWords = words;
    _positions = selected.toList()..sort();
    _controllers.clear();
    for (var i = 0; i < _positions.length; i++) {
      _controllers.add(TextEditingController());
    }

    setState(() {});
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    ScreenshotGuard.disableProtection();
    super.dispose();
  }

  Future<void> _confirm() async {
    if (_mnemonicWords.isEmpty || _positions.isEmpty) return;

    for (var i = 0; i < _positions.length; i++) {
      final expected = _mnemonicWords[_positions[i]].trim().toLowerCase();
      final value = _controllers[i].text.trim().toLowerCase();

      if (expected != value) {
        setState(() {
          _error = 'Recovery phrase incorrecta. Revisá las palabras.';
        });
        return;
      }
    }

    ref
        .read(appLockStateControllerProvider.notifier)
        .forceUnlockedForFreshWallet();

    if (!mounted) return;
    context.go(RouteNames.home);
  }

  @override
  Widget build(BuildContext context) {
    return ScaviumScaffold(
      appBar: AppBar(title: const Text('Confirm recovery phrase')),
      child: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const SectionTitle(
            title: 'Confirm your backup',
            subtitle:
                'Enter the requested words to confirm that you saved your recovery phrase.',
          ),
          const SizedBox(height: 20),
          if (_error != null) ...[
            Text(_error!, style: const TextStyle(color: Colors.redAccent)),
            const SizedBox(height: 16),
          ],
          for (var i = 0; i < _positions.length; i++) ...[
            ScaviumCard(
              child: TextField(
                controller: _controllers[i],
                decoration: InputDecoration(
                  labelText: 'Word #${_positions[i] + 1}',
                ),
              ),
            ),
            const SizedBox(height: 12),
          ],
          const SizedBox(height: 12),
          ScaviumPrimaryButton(text: 'Confirm phrase', onPressed: _confirm),
        ],
      ),
    );
  }
}
