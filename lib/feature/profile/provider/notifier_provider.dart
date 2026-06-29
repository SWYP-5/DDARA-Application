import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../profile_notifier.dart';
import '../util/profile_state.dart';

// autoDispose: 로그아웃 시 폐기되어 다음 로그인 때 새 사용자 프로필을 다시 조회한다.
final profileNotifierProvider =
    NotifierProvider.autoDispose<ProfileNotifier, ProfileState>(
      ProfileNotifier.new,
    );
