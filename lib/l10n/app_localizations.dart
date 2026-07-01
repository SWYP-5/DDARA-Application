import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ko.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('ko')];

  /// 온보딩 1페이지 제목
  ///
  /// In ko, this message translates to:
  /// **'한 장 찍으면 인증샷이 시작'**
  String get onboardingFirstTitle;

  /// 온보딩 1페이지 설명
  ///
  /// In ko, this message translates to:
  /// **'내가 한 포즈, 친구들이 똑같이 따라 찍어요'**
  String get onboardingFirstBody;

  /// 온보딩 2페이지 제목
  ///
  /// In ko, this message translates to:
  /// **'나중에 보면 더 웃겨'**
  String get onboardingSecondTitle;

  /// 온보딩 2페이지 설명
  ///
  /// In ko, this message translates to:
  /// **'따라 찍은 사진들이 모여 기록이 돼요'**
  String get onboardingSecondBody;

  /// 온보딩 3페이지 제목
  ///
  /// In ko, this message translates to:
  /// **'아는 친구끼리만, 초대로만'**
  String get onboardingThirdTitle;

  /// 온보딩 3페이지 설명
  ///
  /// In ko, this message translates to:
  /// **'초대받은 친구만 들어올 수 있어요'**
  String get onboardingThirdBody;

  /// 온보딩 하단 버튼 - 다음 페이지로
  ///
  /// In ko, this message translates to:
  /// **'다음'**
  String get onboardingNext;

  /// 온보딩 마지막 페이지 하단 버튼 - 시작
  ///
  /// In ko, this message translates to:
  /// **'시작하기'**
  String get onboardingStart;

  /// 로그인 화면 슬로건
  ///
  /// In ko, this message translates to:
  /// **'우리끼리 따라찍기'**
  String get loginSlogan;

  /// 카카오 로그인 버튼
  ///
  /// In ko, this message translates to:
  /// **'카카오 로그인'**
  String get loginKakao;

  /// 구글 로그인 버튼
  ///
  /// In ko, this message translates to:
  /// **'Google 로그인'**
  String get loginGoogle;

  /// 로그인 화면 약관·정책 확인 링크
  ///
  /// In ko, this message translates to:
  /// **'이용약관과 개인정보 처리방침 확인'**
  String get loginViewPolicies;

  /// 약관 동의 화면 제목
  ///
  /// In ko, this message translates to:
  /// **'약관에 동의해 주세요'**
  String get termsTitle;

  /// 약관 동의 화면 설명
  ///
  /// In ko, this message translates to:
  /// **'서비스 이용을 위해선 이용약관 동의가 필요해요'**
  String get termsSubtitle;

  /// No description provided for @termsAgreeAll.
  ///
  /// In ko, this message translates to:
  /// **'전체 동의'**
  String get termsAgreeAll;

  /// No description provided for @termsServiceLabel.
  ///
  /// In ko, this message translates to:
  /// **'[필수] 이용약관'**
  String get termsServiceLabel;

  /// No description provided for @termsPrivacyLabel.
  ///
  /// In ko, this message translates to:
  /// **'[필수] 개인정보 처리방침'**
  String get termsPrivacyLabel;

  /// No description provided for @termsAgeLabel.
  ///
  /// In ko, this message translates to:
  /// **'[필수] 만 14세 이상 사용자 이용동의'**
  String get termsAgeLabel;

  /// No description provided for @termsContinueButton.
  ///
  /// In ko, this message translates to:
  /// **'동의하고 계속'**
  String get termsContinueButton;

  /// No description provided for @policyServiceTitle.
  ///
  /// In ko, this message translates to:
  /// **'서비스 이용 약관'**
  String get policyServiceTitle;

  /// No description provided for @policyPrivacyTitle.
  ///
  /// In ko, this message translates to:
  /// **'개인정보 처리방침'**
  String get policyPrivacyTitle;

  /// No description provided for @policyYouthTitle.
  ///
  /// In ko, this message translates to:
  /// **'청소년 보호정책'**
  String get policyYouthTitle;

  /// No description provided for @emptyGroupTitle.
  ///
  /// In ko, this message translates to:
  /// **'아직 참여한 모임이 없어요'**
  String get emptyGroupTitle;

  /// No description provided for @emptyGroupDescription.
  ///
  /// In ko, this message translates to:
  /// **'첫 판을 시작해 친구들에게 보내보세요'**
  String get emptyGroupDescription;

  /// No description provided for @groupCreate.
  ///
  /// In ko, this message translates to:
  /// **'모임 만들기'**
  String get groupCreate;

  /// No description provided for @groupJoin.
  ///
  /// In ko, this message translates to:
  /// **'모임 참여하기'**
  String get groupJoin;

  /// No description provided for @groupEnter.
  ///
  /// In ko, this message translates to:
  /// **'모임 들어가기'**
  String get groupEnter;

  /// No description provided for @groupCountLabel.
  ///
  /// In ko, this message translates to:
  /// **'현재 모임 개수'**
  String get groupCountLabel;

  /// 현재/최대 모임 개수 표시
  ///
  /// In ko, this message translates to:
  /// **'{count}/{maxCount}개'**
  String groupCountValue(int count, int maxCount);

  /// No description provided for @groupCountCaption.
  ///
  /// In ko, this message translates to:
  /// **'모임에 속해 있어요'**
  String get groupCountCaption;

  /// No description provided for @meetingStatusInProgress.
  ///
  /// In ko, this message translates to:
  /// **'진행 중'**
  String get meetingStatusInProgress;

  /// No description provided for @meetingStatusCompleted.
  ///
  /// In ko, this message translates to:
  /// **'종료'**
  String get meetingStatusCompleted;

  /// 멤버가 모임장 1명뿐일 때의 요약
  ///
  /// In ko, this message translates to:
  /// **'{name}님'**
  String meetingMemberOwner(String name);

  /// 모임장 외 여러 명일 때의 멤버 요약
  ///
  /// In ko, this message translates to:
  /// **'{name}님 외 {others}명'**
  String meetingMemberOthers(String name, int others);

  /// 공용 다이얼로그 확인 버튼
  ///
  /// In ko, this message translates to:
  /// **'확인'**
  String get commonConfirm;

  /// 촬영 후 다시 찍기 버튼
  ///
  /// In ko, this message translates to:
  /// **'다시 찍기'**
  String get photoRetake;

  /// 촬영한 사진 올리기 버튼
  ///
  /// In ko, this message translates to:
  /// **'올리기'**
  String get photoUpload;

  /// 게시 전 되돌릴 수 없음을 알리는 확인 다이얼로그 제목
  ///
  /// In ko, this message translates to:
  /// **'게시되면 수정이 불가능합니다.'**
  String get photoPostWarningTitle;

  /// 촬영 화면으로 이동하는 알약 버튼
  ///
  /// In ko, this message translates to:
  /// **'촬영하러 가기'**
  String get photoTakeAction;

  /// No description provided for @groupCreateTitle.
  ///
  /// In ko, this message translates to:
  /// **'모임 이름을 설정해주세요.'**
  String get groupCreateTitle;

  /// No description provided for @groupCreateSubtitle.
  ///
  /// In ko, this message translates to:
  /// **'내가 먼저 찍으면, 친구들이 이 주제를 따라 찍어요'**
  String get groupCreateSubtitle;

  /// No description provided for @groupCreateNameLabel.
  ///
  /// In ko, this message translates to:
  /// **'모임 이름'**
  String get groupCreateNameLabel;

  /// No description provided for @groupCreateNamePlaceholder.
  ///
  /// In ko, this message translates to:
  /// **'예) 마라탕 걸즈'**
  String get groupCreateNamePlaceholder;

  /// No description provided for @groupCreateIntroLabel.
  ///
  /// In ko, this message translates to:
  /// **'한 줄 소개 (선택)'**
  String get groupCreateIntroLabel;

  /// No description provided for @groupCreateIntroPlaceholder.
  ///
  /// In ko, this message translates to:
  /// **'어떤 모임인지 알려주세요'**
  String get groupCreateIntroPlaceholder;

  /// No description provided for @groupCreateSubmit.
  ///
  /// In ko, this message translates to:
  /// **'만들기'**
  String get groupCreateSubmit;

  /// No description provided for @groupJoinTitle.
  ///
  /// In ko, this message translates to:
  /// **'모임 참여'**
  String get groupJoinTitle;

  /// No description provided for @groupJoinHeadline.
  ///
  /// In ko, this message translates to:
  /// **'받은 초대 코드를 입력해주세요'**
  String get groupJoinHeadline;

  /// No description provided for @groupJoinSubtitle.
  ///
  /// In ko, this message translates to:
  /// **'링크로 받았다면, 링크만 눌러도 바로 들어올 수 있어요'**
  String get groupJoinSubtitle;

  /// No description provided for @groupJoinCodeLabel.
  ///
  /// In ko, this message translates to:
  /// **'초대 코드'**
  String get groupJoinCodeLabel;

  /// No description provided for @groupJoinCodePlaceholder.
  ///
  /// In ko, this message translates to:
  /// **'예) ASKD23NSK12'**
  String get groupJoinCodePlaceholder;

  /// No description provided for @starterTitle.
  ///
  /// In ko, this message translates to:
  /// **'스타터 시작하기'**
  String get starterTitle;

  /// No description provided for @starterConceptLabel.
  ///
  /// In ko, this message translates to:
  /// **'컨셉 설명'**
  String get starterConceptLabel;

  /// No description provided for @starterConceptPlaceholder.
  ///
  /// In ko, this message translates to:
  /// **'예) 마라탕 또 먹기'**
  String get starterConceptPlaceholder;

  /// No description provided for @starterConceptLengthError.
  ///
  /// In ko, this message translates to:
  /// **'20자 이내로 입력해 주세요'**
  String get starterConceptLengthError;

  /// No description provided for @startedCameraTitle.
  ///
  /// In ko, this message translates to:
  /// **'따라찍기'**
  String get startedCameraTitle;

  /// No description provided for @groupHeaderStart.
  ///
  /// In ko, this message translates to:
  /// **'내가 먼저 시작하기'**
  String get groupHeaderStart;

  /// No description provided for @groupHeaderTakePhoto.
  ///
  /// In ko, this message translates to:
  /// **'따라찍으러 가기'**
  String get groupHeaderTakePhoto;

  /// No description provided for @groupDetailEmptyTitle.
  ///
  /// In ko, this message translates to:
  /// **'아직 따라찍기가 없어요'**
  String get groupDetailEmptyTitle;

  /// No description provided for @groupDetailLoadError.
  ///
  /// In ko, this message translates to:
  /// **'모임 정보를 불러오지 못했어요.'**
  String get groupDetailLoadError;

  /// No description provided for @groupMembersTitle.
  ///
  /// In ko, this message translates to:
  /// **'사람들'**
  String get groupMembersTitle;

  /// No description provided for @groupMembersAdd.
  ///
  /// In ko, this message translates to:
  /// **'추가하기'**
  String get groupMembersAdd;

  /// No description provided for @memberReportNickname.
  ///
  /// In ko, this message translates to:
  /// **'닉네임 신고'**
  String get memberReportNickname;

  /// No description provided for @memberReportMailSubject.
  ///
  /// In ko, this message translates to:
  /// **'[따라] 닉네임 신고'**
  String get memberReportMailSubject;

  /// 닉네임 신고 메일의 본문. (신고 대상 닉네임 포함)
  ///
  /// In ko, this message translates to:
  /// **'신고할 닉네임: {nickname}\n\n신고 사유를 작성해 주세요.\n'**
  String memberReportMailBody(String nickname);

  /// 닉네임 신고 메일 앱 실행에 실패했을 때 안내
  ///
  /// In ko, this message translates to:
  /// **'메일 앱을 열 수 없어요. ({email})'**
  String memberReportMailFailed(String email);

  /// No description provided for @groupHistoryTitle.
  ///
  /// In ko, this message translates to:
  /// **'지난 따라찍기'**
  String get groupHistoryTitle;

  /// No description provided for @groupHistoryMore.
  ///
  /// In ko, this message translates to:
  /// **'더보기'**
  String get groupHistoryMore;

  /// No description provided for @groupHistoryEmpty.
  ///
  /// In ko, this message translates to:
  /// **'지난 따라찍기가 아직 없어요'**
  String get groupHistoryEmpty;

  /// No description provided for @recordCycleLabel.
  ///
  /// In ko, this message translates to:
  /// **'따라찍기'**
  String get recordCycleLabel;

  /// No description provided for @recordPhotoLabel.
  ///
  /// In ko, this message translates to:
  /// **'함께한 사진'**
  String get recordPhotoLabel;

  /// 지난 따라찍기 카드의 참여 인원 수
  ///
  /// In ko, this message translates to:
  /// **'{count}명 참여'**
  String historyParticipantCount(int count);

  /// 진행 중인 따라찍기의 남은 시간 안내
  ///
  /// In ko, this message translates to:
  /// **'진행 중 · {time} 남음'**
  String startedHeaderRemaining(String time);

  /// 현재 따라찍기 회차
  ///
  /// In ko, this message translates to:
  /// **'{count}번째 따라찍기'**
  String startedHeaderCycle(int count);

  /// 따라찍기를 시작한 사람 안내
  ///
  /// In ko, this message translates to:
  /// **'{name}님이 시작했어요'**
  String startedHeaderStarter(String name);

  /// 마감 시간이 지난 경우 표시
  ///
  /// In ko, this message translates to:
  /// **'마감'**
  String get remainingDeadline;

  /// 남은 시간(시간 단위)
  ///
  /// In ko, this message translates to:
  /// **'{hours}시간'**
  String remainingHours(int hours);

  /// 남은 시간(분 단위)
  ///
  /// In ko, this message translates to:
  /// **'{minutes}분'**
  String remainingMinutes(int minutes);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ko'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ko':
      return AppLocalizationsKo();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
