import 'package:ddara/core/model/group/create_group.dart';
import 'package:ddara/core/network/dto/group/create_group_response.dart';
import 'package:ddara/core/network/dto/group/group_list_response.dart';

import '../../../core/model/group/group_list.dart';

extension CreateGroupMapper on CreateGroupResponse {
  CreateGroup toDomain() {
    return CreateGroup(groupId: groupId);
  }
}

extension GroupListMapper on GroupListResponse {
  GroupList toDomain() {
    return GroupList(
      groups: groups
          .map(
            (group) => Group(
              groupId: group.groupId,
              name: group.name,
              ownerNickname: group.ownerNickname,
              memberCount: group.memberCount,
              currentCycle: group.currentCycle == null
                  ? null
                  : CurrentCycle(
                      cycleId: group.currentCycle!.cycleId,
                      topic: group.currentCycle!.topic,
                      status: group.currentCycle!.status,
                      startedAt: group.currentCycle!.startedAt,
                      thumbnailUrl: group.currentCycle!.thumbnailUrl,
                    ),
            ),
          )
          .toList(),
    );
  }
}
