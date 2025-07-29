import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:gifthunt/src/features/onboarding/domain/models/gift_profile.dart';

part 'gift_profile_notifier.g.dart';

@riverpod
class GiftProfileNotifier extends _$GiftProfileNotifier {
  @override
  GiftProfile build() {
    return const GiftProfile();
  }

  void updateInterests(List<String> interests) {
    state = state.copyWith(interests: interests);
  }

  void updateOccasions(List<String> occasions) {
    state = state.copyWith(occasions: occasions);
  }

  void updateGiftTypes(List<String> giftTypes) {
    state = state.copyWith(giftTypes: giftTypes);
  }

  void updateBudget(double budget) {
    state = state.copyWith(budget: budget);
  }
}