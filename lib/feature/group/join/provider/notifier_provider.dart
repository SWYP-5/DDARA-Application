import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../group_join_notifier.dart';
import '../util/group_join_state.dart';

final groupJoinNotifierProvider =
    NotifierProvider<GroupJoinNotifier, GroupJoinState>(GroupJoinNotifier.new);
