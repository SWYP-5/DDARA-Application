import 'package:ddara/core/model/group/create_group.dart';
import 'package:ddara/core/network/dto/group/create_group_response.dart';

extension CreateGroupMapper on CreateGroupResponse {
  CreateGroup toDomain() {
    return CreateGroup(groupId: groupId);
  }
}
