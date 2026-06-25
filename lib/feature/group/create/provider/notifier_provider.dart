import 'package:ddara/feature/group/create/create_group_notifier.dart';
import 'package:ddara/feature/group/create/util/create_group_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final createGroupNotifierProvider = NotifierProvider<CreateGroupNotifier, CreateGroupState>(
  CreateGroupNotifier.new,
);
