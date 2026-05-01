import 'package:flutter_test/flutter_test.dart';
import 'package:scavium_wallet/app/router/app_route_category.dart';
import 'package:scavium_wallet/app/router/route_names.dart';

void main() {
  group('AppRouteClassifier', () {
    test('classifies primary shell destinations explicitly', () {
      expect(AppRouteClassifier.isPrimary(RouteNames.home), isTrue);
      expect(AppRouteClassifier.isPrimary(RouteNames.assets), isTrue);
      expect(AppRouteClassifier.isPrimary(RouteNames.history), isTrue);
      expect(AppRouteClassifier.isPrimary(RouteNames.settings), isTrue);
    });

    test('keeps public and lock routes outside shell assumptions', () {
      expect(
        AppRouteClassifier.categoryFor(RouteNames.onboarding),
        AppRouteCategory.public,
      );
      expect(
        AppRouteClassifier.categoryFor(RouteNames.walletEntry),
        AppRouteCategory.public,
      );
      expect(
        AppRouteClassifier.categoryFor(RouteNames.lock),
        AppRouteCategory.lock,
      );
      expect(AppRouteClassifier.isShellEligible(RouteNames.lock), isFalse);
    });

    test('keeps action and detail routes outside primary destinations', () {
      expect(
        AppRouteClassifier.categoryFor(RouteNames.send),
        AppRouteCategory.action,
      );
      expect(
        AppRouteClassifier.categoryFor(RouteNames.signing),
        AppRouteCategory.action,
      );
      expect(
        AppRouteClassifier.categoryFor(RouteNames.assetDetail),
        AppRouteCategory.detail,
      );
      expect(
        AppRouteClassifier.categoryFor(RouteNames.transactionDetail),
        AppRouteCategory.detail,
      );
      expect(AppRouteClassifier.isPrimary(RouteNames.send), isFalse);
      expect(AppRouteClassifier.isPrimary(RouteNames.assetDetail), isFalse);
    });

    test('treats unknown future routes as secondary but shell eligible', () {
      expect(
        AppRouteClassifier.categoryFor('/future-secondary'),
        AppRouteCategory.secondary,
      );
      expect(AppRouteClassifier.isShellEligible('/future-secondary'), isTrue);
    });
  });
}
