// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invite_group_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_InviteGroupResponse _$InviteGroupResponseFromJson(Map<String, dynamic> json) =>
    _InviteGroupResponse(
      groupId: (json['groupId'] as num).toInt(),
      name: json['name'] as String,
    );

Map<String, dynamic> _$InviteGroupResponseToJson(
  _InviteGroupResponse instance,
) => <String, dynamic>{'groupId': instance.groupId, 'name': instance.name};
