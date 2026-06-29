import 'package:freezed_annotation/freezed_annotation.dart';

part 'invite_group_response.freezed.dart';
part 'invite_group_response.g.dart';

@freezed
abstract class InviteGroupResponse with _$InviteGroupResponse {
  const factory InviteGroupResponse({
    required int groupId,
    required String name,
  }) = _InviteGroupResponse;

  factory InviteGroupResponse.fromJson(Map<String, dynamic> json) =>
      _$InviteGroupResponseFromJson(json);
}
