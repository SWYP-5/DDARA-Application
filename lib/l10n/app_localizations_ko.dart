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
  String get loginSlogan => '우리끼리 따라찍기';

  @override
  String get loginKakao => '카카오 로그인';

  @override
  String get loginGoogle => 'Google 로그인';

  @override
  String get loginViewPolicies => '이용약관과 개인정보 처리방침 확인';

  @override
  String get termsTitle => '약관에 동의해 주세요';

  @override
  String get termsSubtitle => '서비스 이용을 위해선 이용약관 동의가 필요해요';

  @override
  String get termsAgreeAll => '전체 동의';

  @override
  String get termsServiceLabel => '[필수] 이용약관';

  @override
  String get termsPrivacyLabel => '[필수] 개인정보 처리방침';

  @override
  String get termsAgeLabel => '[필수] 만 14세 이상 사용자 이용동의';

  @override
  String get termsContinueButton => '동의하고 계속';

  @override
  String get policyServiceTitle => '서비스 이용 약관';

  @override
  String get policyPrivacyTitle => '개인정보 처리방침';

  @override
  String get policyYouthTitle => '청소년 보호정책';

  @override
  String get emptyGroupTitle => '아직 참여한 모임이 없어요';

  @override
  String get emptyGroupDescription => '첫 판을 시작해 친구들에게 보내보세요';

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
