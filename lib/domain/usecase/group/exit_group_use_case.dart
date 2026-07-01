import '../../repository/group_repository.dart';

class ExitGroupUseCase {
  final GroupRepository _groupRepository;

  ExitGroupUseCase(this._groupRepository);

  Future<void> exitGroup(int groupId) async {
    await _groupRepository.exitGroup(groupId);
  }
}
