import 'package:ddara/core/model/group/create_group.dart';

abstract interface class GroupRepository {
  Future<CreateGroup> createGroup(String groupName, String description);
}
