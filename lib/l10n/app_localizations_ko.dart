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

  @override
  String get commonConfirm => '확인';

  @override
  String get photoRetake => '다시 찍기';

  @override
  String get photoUpload => '올리기';

  @override
  String get photoPostWarningTitle => '게시되면 수정이 불가능합니다.';

  @override
  String get photoTakeAction => '촬영하러 가기';

  @override
  String get groupCreateTitle => '모임 이름을 설정해주세요.';

  @override
  String get groupCreateSubtitle => '내가 먼저 찍으면, 친구들이 이 주제를 따라 찍어요';

  @override
  String get groupCreateNameLabel => '모임 이름';

  @override
  String get groupCreateNamePlaceholder => '예) 마라탕 걸즈';

  @override
  String get groupCreateIntroLabel => '한 줄 소개 (선택)';

  @override
  String get groupCreateIntroPlaceholder => '어떤 모임인지 알려주세요';

  @override
  String get groupCreateSubmit => '만들기';

  @override
  String get groupJoinTitle => '모임 참여';

  @override
  String get groupJoinHeadline => '받은 초대 코드를 입력해주세요';

  @override
  String get groupJoinSubtitle => '링크로 받았다면, 링크만 눌러도 바로 들어올 수 있어요';

  @override
  String get groupJoinCodeLabel => '초대 코드';

  @override
  String get groupJoinCodePlaceholder => '예) ASKD23NSK12';

  @override
  String get starterTitle => '스타터 시작하기';

  @override
  String get starterConceptLabel => '컨셉 설명';

  @override
  String get starterConceptPlaceholder => '예) 마라탕 또 먹기';

  @override
  String get starterConceptLengthError => '20자 이내로 입력해 주세요';

  @override
  String get startedCameraTitle => '따라찍기';

  @override
  String get groupHeaderStart => '내가 먼저 시작하기';

  @override
  String get groupHeaderTakePhoto => '따라찍으러 가기';

  @override
  String get groupDetailEmptyTitle => '아직 따라찍기가 없어요';

  @override
  String get groupDetailLoadError => '모임 정보를 불러오지 못했어요.';

  @override
  String get groupMembersTitle => '사람들';

  @override
  String get groupMembersAdd => '추가하기';

  @override
  String get groupHistoryTitle => '지난 따라찍기';

  @override
  String get groupHistoryMore => '더보기';

  @override
  String get groupHistoryEmpty => '지난 따라찍기가 아직 없어요';

  @override
  String get recordCycleLabel => '따라찍기';

  @override
  String get recordPhotoLabel => '함께한 사진';

  @override
  String historyParticipantCount(int count) {
    return '$count명 참여';
  }

  @override
  String startedHeaderRemaining(String time) {
    return '진행 중 · $time 남음';
  }

  @override
  String startedHeaderCycle(int count) {
    return '$count번째 따라찍기';
  }

  @override
  String startedHeaderStarter(String name) {
    return '$name님이 시작했어요';
  }

  @override
  String get remainingDeadline => '마감';

  @override
  String remainingHours(int hours) {
    return '$hours시간';
  }

  @override
  String remainingMinutes(int minutes) {
    return '$minutes분';
  }
}
