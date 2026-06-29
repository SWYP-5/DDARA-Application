import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../profile_notifier.dart';
import '../util/profile_state.dart';

final profileNotifierProvider =
    NotifierProvider<ProfileNotifier, ProfileState>(ProfileNotifier.new);
