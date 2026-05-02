import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scavium_wallet/features/home/application/home_auto_refresh_controller.dart';
import 'package:scavium_wallet/features/lock/application/app_lock_state_controller.dart';

class AppLifecycleGuard extends WidgetsBindingObserver {
  final WidgetRef ref;

  AppLifecycleGuard(this.ref);

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final refresh = ref.read(homeAutoRefreshControllerProvider.notifier);

    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused ||
        state == AppLifecycleState.detached) {
      ref.read(appLockStateControllerProvider.notifier).lock();
      refresh.stop();
    }

    if (state == AppLifecycleState.resumed) {
      final isLocked = ref.read(appLockStateControllerProvider);
      if (isLocked) {
        refresh.stop();
        return;
      }

      refresh.start();
      refresh.refreshNow();
    }
  }
}
