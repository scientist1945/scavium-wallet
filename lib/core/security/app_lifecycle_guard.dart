import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scavium_wallet/features/lock/application/app_lock_state_controller.dart';

class AppLifecycleGuard extends WidgetsBindingObserver {
  final WidgetRef ref;

  AppLifecycleGuard(this.ref);

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused ||
        state == AppLifecycleState.detached) {
      ref.read(appLockStateControllerProvider.notifier).lock();
    }
  }
}
