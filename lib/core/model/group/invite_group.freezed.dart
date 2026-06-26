// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'invite_group.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$InviteGroup {

 int get groupId; String get name;
/// Create a copy of InviteGroup
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InviteGroupCopyWith<InviteGroup> get copyWith => _$InviteGroupCopyWithImpl<InviteGroup>(this as InviteGroup, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InviteGroup&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.name, name) || other.name == name));
}


@override
int get hashCode => Object.hash(runtimeType,groupId,name);

@override
String toString() {
  return 'InviteGroup(groupId: $groupId, name: $name)';
}


}

/// @nodoc
abstract mixin class $InviteGroupCopyWith<$Res>  {
  factory $InviteGroupCopyWith(InviteGroup value, $Res Function(InviteGroup) _then) = _$InviteGroupCopyWithImpl;
@useResult
$Res call({
 int groupId, String name
});




}
/// @nodoc
class _$InviteGroupCopyWithImpl<$Res>
    implements $InviteGroupCopyWith<$Res> {
  _$InviteGroupCopyWithImpl(this._self, this._then);

  final InviteGroup _self;
  final $Res Function(InviteGroup) _then;

/// Create a copy of InviteGroup
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? groupId = null,Object? name = null,}) {
  return _then(_self.copyWith(
groupId: null == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [InviteGroup].
extension InviteGroupPatterns on InviteGroup {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InviteGroup value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InviteGroup() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InviteGroup value)  $default,){
final _that = this;
switch (_that) {
case _InviteGroup():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InviteGroup value)?  $default,){
final _that = this;
switch (_that) {
case _InviteGroup() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int groupId,  String name)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InviteGroup() when $default != null:
return $default(_that.groupId,_that.name);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int groupId,  String name)  $default,) {final _that = this;
switch (_that) {
case _InviteGroup():
return $default(_that.groupId,_that.name);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int groupId,  String name)?  $default,) {final _that = this;
switch (_that) {
case _InviteGroup() when $default != null:
return $default(_that.groupId,_that.name);case _:
  return null;

}
}

}

/// @nodoc


class _InviteGroup implements InviteGroup {
  const _InviteGroup({required this.groupId, required this.name});
  

@override final  int groupId;
@override final  String name;

/// Create a copy of InviteGroup
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InviteGroupCopyWith<_InviteGroup> get copyWith => __$InviteGroupCopyWithImpl<_InviteGroup>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InviteGroup&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.name, name) || other.name == name));
}


@override
int get hashCode => Object.hash(runtimeType,groupId,name);

@override
String toString() {
  return 'InviteGroup(groupId: $groupId, name: $name)';
}


}

/// @nodoc
abstract mixin class _$InviteGroupCopyWith<$Res> implements $InviteGroupCopyWith<$Res> {
  factory _$InviteGroupCopyWith(_InviteGroup value, $Res Function(_InviteGroup) _then) = __$InviteGroupCopyWithImpl;
@override @useResult
$Res call({
 int groupId, String name
});




}
/// @nodoc
class __$InviteGroupCopyWithImpl<$Res>
    implements _$InviteGroupCopyWith<$Res> {
  __$InviteGroupCopyWithImpl(this._self, this._then);

  final _InviteGroup _self;
  final $Res Function(_InviteGroup) _then;

/// Create a copy of InviteGroup
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? groupId = null,Object? name = null,}) {
  return _then(_InviteGroup(
groupId: null == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
