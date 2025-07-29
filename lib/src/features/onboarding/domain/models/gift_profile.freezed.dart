// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gift_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GiftProfile {

 List<String> get interests; List<String> get occasions; List<String> get giftTypes; double get budget;
/// Create a copy of GiftProfile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GiftProfileCopyWith<GiftProfile> get copyWith => _$GiftProfileCopyWithImpl<GiftProfile>(this as GiftProfile, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GiftProfile&&const DeepCollectionEquality().equals(other.interests, interests)&&const DeepCollectionEquality().equals(other.occasions, occasions)&&const DeepCollectionEquality().equals(other.giftTypes, giftTypes)&&(identical(other.budget, budget) || other.budget == budget));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(interests),const DeepCollectionEquality().hash(occasions),const DeepCollectionEquality().hash(giftTypes),budget);

@override
String toString() {
  return 'GiftProfile(interests: $interests, occasions: $occasions, giftTypes: $giftTypes, budget: $budget)';
}


}

/// @nodoc
abstract mixin class $GiftProfileCopyWith<$Res>  {
  factory $GiftProfileCopyWith(GiftProfile value, $Res Function(GiftProfile) _then) = _$GiftProfileCopyWithImpl;
@useResult
$Res call({
 List<String> interests, List<String> occasions, List<String> giftTypes, double budget
});




}
/// @nodoc
class _$GiftProfileCopyWithImpl<$Res>
    implements $GiftProfileCopyWith<$Res> {
  _$GiftProfileCopyWithImpl(this._self, this._then);

  final GiftProfile _self;
  final $Res Function(GiftProfile) _then;

/// Create a copy of GiftProfile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? interests = null,Object? occasions = null,Object? giftTypes = null,Object? budget = null,}) {
  return _then(_self.copyWith(
interests: null == interests ? _self.interests : interests // ignore: cast_nullable_to_non_nullable
as List<String>,occasions: null == occasions ? _self.occasions : occasions // ignore: cast_nullable_to_non_nullable
as List<String>,giftTypes: null == giftTypes ? _self.giftTypes : giftTypes // ignore: cast_nullable_to_non_nullable
as List<String>,budget: null == budget ? _self.budget : budget // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [GiftProfile].
extension GiftProfilePatterns on GiftProfile {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GiftProfile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GiftProfile() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GiftProfile value)  $default,){
final _that = this;
switch (_that) {
case _GiftProfile():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GiftProfile value)?  $default,){
final _that = this;
switch (_that) {
case _GiftProfile() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<String> interests,  List<String> occasions,  List<String> giftTypes,  double budget)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GiftProfile() when $default != null:
return $default(_that.interests,_that.occasions,_that.giftTypes,_that.budget);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<String> interests,  List<String> occasions,  List<String> giftTypes,  double budget)  $default,) {final _that = this;
switch (_that) {
case _GiftProfile():
return $default(_that.interests,_that.occasions,_that.giftTypes,_that.budget);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<String> interests,  List<String> occasions,  List<String> giftTypes,  double budget)?  $default,) {final _that = this;
switch (_that) {
case _GiftProfile() when $default != null:
return $default(_that.interests,_that.occasions,_that.giftTypes,_that.budget);case _:
  return null;

}
}

}

/// @nodoc


class _GiftProfile implements GiftProfile {
  const _GiftProfile({final  List<String> interests = const [], final  List<String> occasions = const [], final  List<String> giftTypes = const [], this.budget = 0}): _interests = interests,_occasions = occasions,_giftTypes = giftTypes;
  

 final  List<String> _interests;
@override@JsonKey() List<String> get interests {
  if (_interests is EqualUnmodifiableListView) return _interests;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_interests);
}

 final  List<String> _occasions;
@override@JsonKey() List<String> get occasions {
  if (_occasions is EqualUnmodifiableListView) return _occasions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_occasions);
}

 final  List<String> _giftTypes;
@override@JsonKey() List<String> get giftTypes {
  if (_giftTypes is EqualUnmodifiableListView) return _giftTypes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_giftTypes);
}

@override@JsonKey() final  double budget;

/// Create a copy of GiftProfile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GiftProfileCopyWith<_GiftProfile> get copyWith => __$GiftProfileCopyWithImpl<_GiftProfile>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GiftProfile&&const DeepCollectionEquality().equals(other._interests, _interests)&&const DeepCollectionEquality().equals(other._occasions, _occasions)&&const DeepCollectionEquality().equals(other._giftTypes, _giftTypes)&&(identical(other.budget, budget) || other.budget == budget));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_interests),const DeepCollectionEquality().hash(_occasions),const DeepCollectionEquality().hash(_giftTypes),budget);

@override
String toString() {
  return 'GiftProfile(interests: $interests, occasions: $occasions, giftTypes: $giftTypes, budget: $budget)';
}


}

/// @nodoc
abstract mixin class _$GiftProfileCopyWith<$Res> implements $GiftProfileCopyWith<$Res> {
  factory _$GiftProfileCopyWith(_GiftProfile value, $Res Function(_GiftProfile) _then) = __$GiftProfileCopyWithImpl;
@override @useResult
$Res call({
 List<String> interests, List<String> occasions, List<String> giftTypes, double budget
});




}
/// @nodoc
class __$GiftProfileCopyWithImpl<$Res>
    implements _$GiftProfileCopyWith<$Res> {
  __$GiftProfileCopyWithImpl(this._self, this._then);

  final _GiftProfile _self;
  final $Res Function(_GiftProfile) _then;

/// Create a copy of GiftProfile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? interests = null,Object? occasions = null,Object? giftTypes = null,Object? budget = null,}) {
  return _then(_GiftProfile(
interests: null == interests ? _self._interests : interests // ignore: cast_nullable_to_non_nullable
as List<String>,occasions: null == occasions ? _self._occasions : occasions // ignore: cast_nullable_to_non_nullable
as List<String>,giftTypes: null == giftTypes ? _self._giftTypes : giftTypes // ignore: cast_nullable_to_non_nullable
as List<String>,budget: null == budget ? _self.budget : budget // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
