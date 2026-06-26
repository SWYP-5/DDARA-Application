import 'package:freezed_annotation/freezed_annotation.dart';

part 'invite_group.freezed.dart';

@freezed
abstract class InviteGroup with _$InviteGroup {
  const factory InviteGroup({
    required int groupId,
    required String name,
  }) = _InviteGroup;
}
