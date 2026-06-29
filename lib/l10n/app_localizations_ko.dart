// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get onboardingFirstTitle => '한 장 찍으면 인증샷이 시작';

  @override
  String get onboardingFirstBody => '내가 한 포즈, 친구들이 똑같이 따라 찍어요';

  @override
  String get onboardingSecondTitle => '나중에 보면 더 웃겨';

  @override
  String get onboardingSecondBody => '따라 찍은 사진들이 모여 기록이 돼요';

  @override
  String get onboardingThirdTitle => '아는 친구끼리만, 초대로만';

  @override
  String get onboardingThirdBody => '초대받은 친구만 들어올 수 있어요';

  @override
  String get onboardingNext => '다음';

  @override
  String get onboardingStart => '시작하기';

  @override
  String get emptyGroupTitle => '아직 참여한 모임이 없어요';

  @override
  String get emptyGroupDescription => '모임을 만들어 친구들을 초대해 보세요';

  @override
  String get groupCreate => '모임 만들기';

  @override
  String get groupJoin => '모임 참여하기';

  @override
  String get groupEnter => '모임 들어가기';

  @override
  String get groupCountLabel => '현재 모임 개수';

  @override
  String groupCountValue(int count, int maxCount) {
    return '$count/$maxCount개';
  }

  @override
  String get groupCountCaption => '모임에 속해 있어요';

  @override
  String get meetingStatusInProgress => '진행 중';

  @override
  String get meetingStatusCompleted => '종료';

  @override
  String meetingMemberOwner(String name) {
    return '$name님';
  }

  @override
  String meetingMemberOthers(String name, int others) {
    return '$name님 외 $others명';
  }
}
