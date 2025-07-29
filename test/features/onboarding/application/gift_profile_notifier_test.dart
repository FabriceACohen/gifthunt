import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gifthunt/src/features/onboarding/application/gift_profile_notifier.dart';
import 'package:gifthunt/src/features/onboarding/domain/models/gift_profile.dart';

void main() {
  group('GiftProfileNotifier', () {
    test('should update interests', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(giftProfileNotifierProvider.notifier);
      final initialProfile = container.read(giftProfileNotifierProvider);

      expect(initialProfile.interests, isEmpty);

      notifier.updateInterests(['Technologie', 'Sport']);
      final updatedProfile = container.read(giftProfileNotifierProvider);

      expect(updatedProfile.interests, ['Technologie', 'Sport']);
    });

    test('should update occasions', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(giftProfileNotifierProvider.notifier);
      final initialProfile = container.read(giftProfileNotifierProvider);

      expect(initialProfile.occasions, isEmpty);

      notifier.updateOccasions(['Anniversaire']);
      final updatedProfile = container.read(giftProfileNotifierProvider);

      expect(updatedProfile.occasions, ['Anniversaire']);
    });

    test('should update gift types', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(giftProfileNotifierProvider.notifier);
      final initialProfile = container.read(giftProfileNotifierProvider);

      expect(initialProfile.giftTypes, isEmpty);

      notifier.updateGiftTypes(['Expérience']);
      final updatedProfile = container.read(giftProfileNotifierProvider);

      expect(updatedProfile.giftTypes, ['Expérience']);
    });

    test('should update budget', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(giftProfileNotifierProvider.notifier);
      final initialProfile = container.read(giftProfileNotifierProvider);

      expect(initialProfile.budget, 0.0);

      notifier.updateBudget(500.0);
      final updatedProfile = container.read(giftProfileNotifierProvider);

      expect(updatedProfile.budget, 500.0);
    });

    test('should return initial GiftProfile when no updates', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final initialProfile = container.read(giftProfileNotifierProvider);

      expect(initialProfile.interests, isEmpty);
      expect(initialProfile.occasions, isEmpty);
      expect(initialProfile.giftTypes, isEmpty);
      expect(initialProfile.budget, 0.0);
    });
  });
}