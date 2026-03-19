import 'package:flutter_riverpod/flutter_riverpod.dart';

final appLockStateControllerProvider =
    NotifierProvider<AppLockStateController, bool>(AppLockStateController.new);

class AppLockStateController extends Notifier<bool> {
  @override
  bool build() => true;

  void lock() {
    state = true;
  }

  void unlock() {
    state = false;
  }

  void forceUnlockedForFreshWallet() {
    state = false;
  }
}
