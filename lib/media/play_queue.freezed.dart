// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'play_queue.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PlayQueue {

/// Client-generated UUID identifying this queue for the session.
 String get id; List<MediaItem> get items;/// Server kind that owns this queue's items (typically `"jellyfin"`).
 String get backendId; int? get currentIndex; bool get shuffled;
/// Create a copy of PlayQueue
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlayQueueCopyWith<PlayQueue> get copyWith => _$PlayQueueCopyWithImpl<PlayQueue>(this as PlayQueue, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlayQueue&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.backendId, backendId) || other.backendId == backendId)&&(identical(other.currentIndex, currentIndex) || other.currentIndex == currentIndex)&&(identical(other.shuffled, shuffled) || other.shuffled == shuffled));
}


@override
int get hashCode => Object.hash(runtimeType,id,const DeepCollectionEquality().hash(items),backendId,currentIndex,shuffled);

@override
String toString() {
  return 'PlayQueue(id: $id, items: $items, backendId: $backendId, currentIndex: $currentIndex, shuffled: $shuffled)';
}


}

/// @nodoc
abstract mixin class $PlayQueueCopyWith<$Res>  {
  factory $PlayQueueCopyWith(PlayQueue value, $Res Function(PlayQueue) _then) = _$PlayQueueCopyWithImpl;
@useResult
$Res call({
 String id, List<MediaItem> items, String backendId, int? currentIndex, bool shuffled
});




}
/// @nodoc
class _$PlayQueueCopyWithImpl<$Res>
    implements $PlayQueueCopyWith<$Res> {
  _$PlayQueueCopyWithImpl(this._self, this._then);

  final PlayQueue _self;
  final $Res Function(PlayQueue) _then;

/// Create a copy of PlayQueue
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? items = null,Object? backendId = null,Object? currentIndex = freezed,Object? shuffled = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<MediaItem>,backendId: null == backendId ? _self.backendId : backendId // ignore: cast_nullable_to_non_nullable
as String,currentIndex: freezed == currentIndex ? _self.currentIndex : currentIndex // ignore: cast_nullable_to_non_nullable
as int?,shuffled: null == shuffled ? _self.shuffled : shuffled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PlayQueue].
extension PlayQueuePatterns on PlayQueue {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( LocalPlayQueue value)?  local,required TResult orElse(),}){
final _that = this;
switch (_that) {
case LocalPlayQueue() when local != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( LocalPlayQueue value)  local,}){
final _that = this;
switch (_that) {
case LocalPlayQueue():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( LocalPlayQueue value)?  local,}){
final _that = this;
switch (_that) {
case LocalPlayQueue() when local != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String id,  List<MediaItem> items,  String backendId,  int? currentIndex,  bool shuffled)?  local,required TResult orElse(),}) {final _that = this;
switch (_that) {
case LocalPlayQueue() when local != null:
return local(_that.id,_that.items,_that.backendId,_that.currentIndex,_that.shuffled);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String id,  List<MediaItem> items,  String backendId,  int? currentIndex,  bool shuffled)  local,}) {final _that = this;
switch (_that) {
case LocalPlayQueue():
return local(_that.id,_that.items,_that.backendId,_that.currentIndex,_that.shuffled);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String id,  List<MediaItem> items,  String backendId,  int? currentIndex,  bool shuffled)?  local,}) {final _that = this;
switch (_that) {
case LocalPlayQueue() when local != null:
return local(_that.id,_that.items,_that.backendId,_that.currentIndex,_that.shuffled);case _:
  return null;

}
}

}

/// @nodoc


class LocalPlayQueue extends PlayQueue {
  const LocalPlayQueue({required this.id, required final  List<MediaItem> items, required this.backendId, this.currentIndex, this.shuffled = false}): _items = items,super._();
  

/// Client-generated UUID identifying this queue for the session.
@override final  String id;
 final  List<MediaItem> _items;
@override List<MediaItem> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

/// Server kind that owns this queue's items (typically `"jellyfin"`).
@override final  String backendId;
@override final  int? currentIndex;
@override@JsonKey() final  bool shuffled;

/// Create a copy of PlayQueue
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LocalPlayQueueCopyWith<LocalPlayQueue> get copyWith => _$LocalPlayQueueCopyWithImpl<LocalPlayQueue>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LocalPlayQueue&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.backendId, backendId) || other.backendId == backendId)&&(identical(other.currentIndex, currentIndex) || other.currentIndex == currentIndex)&&(identical(other.shuffled, shuffled) || other.shuffled == shuffled));
}


@override
int get hashCode => Object.hash(runtimeType,id,const DeepCollectionEquality().hash(_items),backendId,currentIndex,shuffled);

@override
String toString() {
  return 'PlayQueue.local(id: $id, items: $items, backendId: $backendId, currentIndex: $currentIndex, shuffled: $shuffled)';
}


}

/// @nodoc
abstract mixin class $LocalPlayQueueCopyWith<$Res> implements $PlayQueueCopyWith<$Res> {
  factory $LocalPlayQueueCopyWith(LocalPlayQueue value, $Res Function(LocalPlayQueue) _then) = _$LocalPlayQueueCopyWithImpl;
@override @useResult
$Res call({
 String id, List<MediaItem> items, String backendId, int? currentIndex, bool shuffled
});




}
/// @nodoc
class _$LocalPlayQueueCopyWithImpl<$Res>
    implements $LocalPlayQueueCopyWith<$Res> {
  _$LocalPlayQueueCopyWithImpl(this._self, this._then);

  final LocalPlayQueue _self;
  final $Res Function(LocalPlayQueue) _then;

/// Create a copy of PlayQueue
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? items = null,Object? backendId = null,Object? currentIndex = freezed,Object? shuffled = null,}) {
  return _then(LocalPlayQueue(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<MediaItem>,backendId: null == backendId ? _self.backendId : backendId // ignore: cast_nullable_to_non_nullable
as String,currentIndex: freezed == currentIndex ? _self.currentIndex : currentIndex // ignore: cast_nullable_to_non_nullable
as int?,shuffled: null == shuffled ? _self.shuffled : shuffled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
