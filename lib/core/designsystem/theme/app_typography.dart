import 'package:flutter/widgets.dart';

/// 타이포그래피 토큰 (Figma Type Scale · 8단계).
///
/// 다크 테마 기준. 폰트는 **Pretendard**.
/// (조직 폰트 적용 전까지 Noto Sans KR 로 임시 표시 중이라 SemiBold 등 일부
///  굵기가 다르게 보일 수 있음. 토큰은 **의도된 굵기** 기준으로 정의한다.)
///
/// 변환 규칙:
/// - `letterSpacing`(px) = fontSize × 자간%   (예: 40 × -2% = -0.8)
/// - `height`(배수)       = 행간(px) ÷ fontSize (예: 48 ÷ 40 = 1.2)
///
/// 패턴: 큰 글자일수록 자간을 좁히고(-2%), 작은 글자는 살짝 벌린다(+0.3%) —
/// 한글이 답답해 보이지 않게 하기 위함.
///
/// 굵기: Bold=w700 · SemiBold=w600 · Medium=w500 · Regular=w400.
abstract final class AppTypography {
  const AppTypography._();

  static const String fontFamily = 'Pretendard';

  /// Display · 40 / Bold · 행간 48 · 자간 -2%
  /// 화면에 한 번만 쓰는 제일 큰 글자 (온보딩·연말 리포트 표지).
  static const TextStyle display = TextStyle(
    fontFamily: fontFamily,
    fontSize: 40,
    fontWeight: FontWeight.w700,
    height: 48 / 40,
    letterSpacing: 40 * -0.02,
  );

  /// Headline/Large · 24 / SemiBold · 행간 32 · 자간 -1.5%
  /// 화면 진입 시 처음 보이는 제목 (메인 헤더·모임 이름).
  static const TextStyle headlineLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.w600,
    height: 32 / 24,
    letterSpacing: 24 * -0.015,
  );

  /// Headline/Medium · 20 / SemiBold · 행간 28 · 자간 -1%
  /// 화면 안 구역 제목 ("내 모임", "이번 주 만남").
  static const TextStyle headlineMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 28 / 20,
    letterSpacing: 20 * -0.01,
  );

  /// Title · 18 / SemiBold · 행간 26 · 자간 -1%
  /// 카드·만남 하나하나의 제목.
  static const TextStyle title = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 26 / 18,
    letterSpacing: 18 * -0.01,
  );

  /// Body/Large · 16 / Regular · 행간 24 · 자간 -0.3%
  /// 본문 (메모·공동기록·회상 카드 글).
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 24 / 16,
    letterSpacing: 16 * -0.003,
  );

  /// Body/Medium · 14 / Regular · 행간 21 · 자간 0%
  /// 작은 본문 (카드 부가 정보·모달 설명).
  static const TextStyle bodyMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 21 / 14,
    letterSpacing: 0,
  );

  /// Label · 13 / Medium · 행간 18 · 자간 0%
  /// 버튼·탭·칩에 들어가는 글자.
  static const TextStyle label = TextStyle(
    fontFamily: fontFamily,
    fontSize: 13,
    fontWeight: FontWeight.w500,
    height: 18 / 13,
    letterSpacing: 0,
  );

  /// Caption · 12 / Regular · 행간 17 · 자간 +0.3%
  /// 제일 작은 글자 (시간·상태 표시).
  static const TextStyle caption = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 17 / 12,
    letterSpacing: 12 * 0.003,
  );
}
