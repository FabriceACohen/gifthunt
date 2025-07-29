import 'package:freezed_annotation/freezed_annotation.dart';

part 'gift_profile.freezed.dart';

@freezed
sealed class GiftProfile with _$GiftProfile {
  const factory GiftProfile({
    @Default([]) List<String> interests,
    @Default([]) List<String> occasions,
    @Default([]) List<String> giftTypes,
    @Default(0) double budget,
  }) = _GiftProfile;
}