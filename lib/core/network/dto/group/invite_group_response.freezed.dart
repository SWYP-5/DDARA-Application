// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'invite_group_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$InviteGroupResponse {

 int get groupId; String get name;
/// Create a copy of InviteGroupResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InviteGroupResponseCopyWith<InviteGroupResponse> get copyWith => _$InviteGroupResponseCopyWithImpl<InviteGroupResponse>(this as InviteGroupResponse, _$identity);

  /// Serializes this InviteGroupResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InviteGroupResponse&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,groupId,name);

@override
String toString() {
  return 'InviteGroupResponse(groupId: $groupId, name: $name)';
}


}

/// @nodoc
abstract mixin class $InviteGroupResponseCopyWith<$Res>  {
  factory $InviteGroupResponseCopyWith(InviteGroupResponse value, $Res Function(InviteGroupResponse) _then) = _$InviteGroupResponseCopyWithImpl;
@useResult
$Res call({
 int groupId, String name
});




}
/// @nodoc
class _$InviteGroupResponseCopyWithImpl<$Res>
    implements $InviteGroupResponseCopyWith<$Res> {
  _$InviteGroupResponseCopyWithImpl(this._self, this._then);

  final InviteGroupResponse _self;
  final $Res Function(InviteGroupResponse) _then;

/// Create a copy of InviteGroupResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? groupId = null,Object? name = null,}) {
  return _then(_self.copyWith(
groupId: null == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [InviteGroupResponse].
extension InviteGroupResponsePatterns on InviteGroupResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InviteGroupResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InviteGroupResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InviteGroupResponse value)  $default,){
final _that = this;
switch (_that) {
case _InviteGroupResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InviteGroupResponse value)?  $default,){
final _that = this;
switch (_that) {
case _InviteGroupResponse() when $default != null:
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
case _InviteGroupResponse() when $default != null:
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
case _InviteGroupResponse():
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
case _InviteGroupResponse() when $default != null:
return $default(_that.groupId,_that.name);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _InviteGroupResponse implements InviteGroupResponse {
  const _InviteGroupResponse({required this.groupId, required this.name});
  factory _InviteGroupResponse.fromJson(Map<String, dynamic> json) => _$InviteGroupResponseFromJson(json);

@override final  int groupId;
@override final  String name;

/// Create a copy of InviteGroupResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InviteGroupResponseCopyWith<_InviteGroupResponse> get copyWith => __$InviteGroupResponseCopyWithImpl<_InviteGroupResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InviteGroupResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InviteGroupResponse&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,groupId,name);

@override
String toString() {
  return 'InviteGroupResponse(groupId: $groupId, name: $name)';
}


}

/// @nodoc
abstract mixin class _$InviteGroupResponseCopyWith<$Res> implements $InviteGroupResponseCopyWith<$Res> {
  factory _$InviteGroupResponseCopyWith(_InviteGroupResponse value, $Res Function(_InviteGroupResponse) _then) = __$InviteGroupResponseCopyWithImpl;
@override @useResult
$Res call({
 int groupId, String name
});




}
/// @nodoc
class __$InviteGroupResponseCopyWithImpl<$Res>
    implements _$InviteGroupResponseCopyWith<$Res> {
  __$InviteGroupResponseCopyWithImpl(this._self, this._then);

  final _InviteGroupResponse _self;
  final $Res Function(_InviteGroupResponse) _then;

/// Create a copy of InviteGroupResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? groupId = null,Object? name = null,}) {
  return _then(_InviteGroupResponse(
groupId: null == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
