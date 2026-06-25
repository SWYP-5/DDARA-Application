import 'package:ddara/feature/group/detail/group_page_notifier.dart';
import 'package:ddara/feature/group/detail/util/group_page_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final groupPageNotifierProvider =
    NotifierProvider.family<GroupPageNotifier, GroupPageState, int>(
      GroupPageNotifier.new,
    );
