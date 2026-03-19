import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:scavium_wallet/app/router/route_names.dart';
import 'package:scavium_wallet/features/lock/application/lock_controller.dart';
import 'package:scavium_wallet/shared/widgets/scavium_primary_button.dart';
import 'package:scavium_wallet/shared/widgets/scavium_scaffold.dart';
import 'package:scavium_wallet/shared/widgets/section_title.dart';

class LockScreen extends ConsumerStatefulWidget {
  const LockScreen({super.key});

  @override
  ConsumerState<LockScreen> createState() => _LockScreenState();
}

class _LockScreenState extends ConsumerState<LockScreen> {
  final _controller = TextEditingController();
  String? _error;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _unlock() async {
    final ok = await ref
        .read(lockControllerProvider.notifier)
        .validatePin(_controller.text);

    if (!mounted) return;

    if (ok) {
      context.go(RouteNames.home);
    } else {
      setState(() {
        _error = 'Invalid PIN';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaviumScaffold(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Spacer(),
            const SectionTitle(
              title: 'Unlock wallet',
              subtitle: 'Enter your PIN to access SCAVIUM Wallet.',
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _controller,
              obscureText: true,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: 'PIN', errorText: _error),
            ),
            const SizedBox(height: 16),
            ScaviumPrimaryButton(text: 'Unlock', onPressed: _unlock),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
