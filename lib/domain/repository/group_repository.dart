import 'package:ddara/core/model/group/create_group.dart';
import 'package:ddara/core/model/group/invite_group.dart';

import '../../core/model/group/group_detail.dart';
import '../../core/model/group/group_list.dart';

abstract interface class GroupRepository {
  Future<CreateGroup> createGroup(String groupName, String description);

  Future<GroupList> getGroupList();

  Future<GroupDetail> getGroupDetail(int groupId);

  Future<InviteGroup> getInviteGroup(String inviteCode);
}
