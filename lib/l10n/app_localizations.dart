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
