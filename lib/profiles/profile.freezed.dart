// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Profile {

 String get id; String get displayName; String? get avatarThumbUrl;/// Hashed PIN if set. The raw PIN is never persisted; see [computePinHash].
 String? get pinHash; int get sortOrder; DateTime get createdAt; DateTime? get lastUsedAt;
/// Create a copy of Profile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileCopyWith<Profile> get copyWith => _$ProfileCopyWithImpl<Profile>(this as Profile, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Profile&&(identical(other.id, id) || other.id == id)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.avatarThumbUrl, avatarThumbUrl) || other.avatarThumbUrl == avatarThumbUrl)&&(identical(other.pinHash, pinHash) || other.pinHash == pinHash)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.lastUsedAt, lastUsedAt) || other.lastUsedAt == lastUsedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,displayName,avatarThumbUrl,pinHash,sortOrder,createdAt,lastUsedAt);

@override
String toString() {
  return 'Profile(id: $id, displayName: $displayName, avatarThumbUrl: $avatarThumbUrl, pinHash: $pinHash, sortOrder: $sortOrder, createdAt: $createdAt, lastUsedAt: $lastUsedAt)';
}


}

/// @nodoc
abstract mixin class $ProfileCopyWith<$Res>  {
  factory $ProfileCopyWith(Profile value, $Res Function(Profile) _then) = _$ProfileCopyWithImpl;
@useResult
$Res call({
 String id, String displayName, String? avatarThumbUrl, String? pinHash, int sortOrder, DateTime createdAt, DateTime? lastUsedAt
});




}
/// @nodoc
class _$ProfileCopyWithImpl<$Res>
    implements $ProfileCopyWith<$Res> {
  _$ProfileCopyWithImpl(this._self, this._then);

  final Profile _self;
  final $Res Function(Profile) _then;

/// Create a copy of Profile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? displayName = null,Object? avatarThumbUrl = freezed,Object? pinHash = freezed,Object? sortOrder = null,Object? createdAt = null,Object? lastUsedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,avatarThumbUrl: freezed == avatarThumbUrl ? _self.avatarThumbUrl : avatarThumbUrl // ignore: cast_nullable_to_non_nullable
as String?,pinHash: freezed == pinHash ? _self.pinHash : pinHash // ignore: cast_nullable_to_non_nullable
as String?,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,lastUsedAt: freezed == lastUsedAt ? _self.lastUsedAt : lastUsedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [Profile].
extension ProfilePatterns on Profile {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( LocalProfile value)?  local,required TResult orElse(),}){
final _that = this;
switch (_that) {
case LocalProfile() when local != null:
return local(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( LocalProfile value)  local,}){
final _that = this;
switch (_that) {
case LocalProfile():
return local(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( LocalProfile value)?  local,}){
final _that = this;
switch (_that) {
case LocalProfile() when local != null:
return local(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String id,  String displayName,  String? avatarThumbUrl,  String? pinHash,  int sortOrder,  DateTime createdAt,  DateTime? lastUsedAt)?  local,required TResult orElse(),}) {final _that = this;
switch (_that) {
case LocalProfile() when local != null:
return local(_that.id,_that.displayName,_that.avatarThumbUrl,_that.pinHash,_that.sortOrder,_that.createdAt,_that.lastUsedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String id,  String displayName,  String? avatarThumbUrl,  String? pinHash,  int sortOrder,  DateTime createdAt,  DateTime? lastUsedAt)  local,}) {final _that = this;
switch (_that) {
case LocalProfile():
return local(_that.id,_that.displayName,_that.avatarThumbUrl,_that.pinHash,_that.sortOrder,_that.createdAt,_that.lastUsedAt);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String id,  String displayName,  String? avatarThumbUrl,  String? pinHash,  int sortOrder,  DateTime createdAt,  DateTime? lastUsedAt)?  local,}) {final _that = this;
switch (_that) {
case LocalProfile() when local != null:
return local(_that.id,_that.displayName,_that.avatarThumbUrl,_that.pinHash,_that.sortOrder,_that.createdAt,_that.lastUsedAt);case _:
  return null;

}
}

}

/// @nodoc


class LocalProfile extends Profile {
  const LocalProfile({required this.id, required this.displayName, this.avatarThumbUrl, this.pinHash, this.sortOrder = 0, required this.createdAt, this.lastUsedAt}): super._();
  

@override final  String id;
@override final  String displayName;
@override final  String? avatarThumbUrl;
/// Hashed PIN if set. The raw PIN is never persisted; see [computePinHash].
@override final  String? pinHash;
@override@JsonKey() final  int sortOrder;
@override final  DateTime createdAt;
@override final  DateTime? lastUsedAt;

/// Create a copy of Profile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LocalProfileCopyWith<LocalProfile> get copyWith => _$LocalProfileCopyWithImpl<LocalProfile>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LocalProfile&&(identical(other.id, id) || other.id == id)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.avatarThumbUrl, avatarThumbUrl) || other.avatarThumbUrl == avatarThumbUrl)&&(identical(other.pinHash, pinHash) || other.pinHash == pinHash)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.lastUsedAt, lastUsedAt) || other.lastUsedAt == lastUsedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,displayName,avatarThumbUrl,pinHash,sortOrder,createdAt,lastUsedAt);

@override
String toString() {
  return 'Profile.local(id: $id, displayName: $displayName, avatarThumbUrl: $avatarThumbUrl, pinHash: $pinHash, sortOrder: $sortOrder, createdAt: $createdAt, lastUsedAt: $lastUsedAt)';
}


}

/// @nodoc
abstract mixin class $LocalProfileCopyWith<$Res> implements $ProfileCopyWith<$Res> {
  factory $LocalProfileCopyWith(LocalProfile value, $Res Function(LocalProfile) _then) = _$LocalProfileCopyWithImpl;
@override @useResult
$Res call({
 String id, String displayName, String? avatarThumbUrl, String? pinHash, int sortOrder, DateTime createdAt, DateTime? lastUsedAt
});




}
/// @nodoc
class _$LocalProfileCopyWithImpl<$Res>
    implements $LocalProfileCopyWith<$Res> {
  _$LocalProfileCopyWithImpl(this._self, this._then);

  final LocalProfile _self;
  final $Res Function(LocalProfile) _then;

/// Create a copy of Profile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? displayName = null,Object? avatarThumbUrl = freezed,Object? pinHash = freezed,Object? sortOrder = null,Object? createdAt = null,Object? lastUsedAt = freezed,}) {
  return _then(LocalProfile(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,avatarThumbUrl: freezed == avatarThumbUrl ? _self.avatarThumbUrl : avatarThumbUrl // ignore: cast_nullable_to_non_nullable
as String?,pinHash: freezed == pinHash ? _self.pinHash : pinHash // ignore: cast_nullable_to_non_nullable
as String?,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,lastUsedAt: freezed == lastUsedAt ? _self.lastUsedAt : lastUsedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
