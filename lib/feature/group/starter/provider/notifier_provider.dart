import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../starter_notifier.dart';
import '../util/starter_state.dart';

final starterNotifierProvider =
    NotifierProvider<StarterNotifier, StarterState>(StarterNotifier.new);
