import 'dart:async';

import 'package:app_links/app_links.dart';

/// 초대 딥링크 수신 서비스. (research.md 섹션 5 / 작업 6번)
///
/// 처리 대상 URI 두 종류:
/// - (A) 카카오 실행 파라미터: `kakao{KEY}://kakaolink?invite_code=...`
/// - (B) App/Universal Link: `https://ddara.app/invite?code=...`
///
/// 둘 다 결국 초대코드를 [onInvite] 로 전달한다. 딥링크 핸들러 이중화를 피하기
/// 위해 Flutter 기본 딥링크는 비활성화하고(Android `flutter_deeplinking_enabled=false`)
/// 이 서비스가 단일 진입점으로 동작한다.
class DeepLinkService {
  DeepLinkService({required this.onInvite});

  /// 초대코드를 파싱했을 때 호출되는 콜백. (라우팅 등)
  final void Function(String inviteCode) onInvite;

  final AppLinks _appLinks = AppLinks();
  StreamSubscription<Uri>? _subscription;

  /// 콜드 스타트(링크로 앱 실행) + 실행 중 수신 스트림을 모두 구독한다.
  Future<void> init() async {
    // 앱이 죽어있다 링크로 켜진 경우의 최초 URI.
    // (uriLinkStream 은 이 초기 링크를 emit 하지 않으므로 별도로 처리)
    final initialUri = await _appLinks.getInitialLink();
    if (initialUri != null) _handle(initialUri);

    // 앱이 떠 있는 중 들어오는 링크.
    _subscription = _appLinks.uriLinkStream.listen(_handle);
  }

  void _handle(Uri uri) {
    // 카카오 로그인 콜백(kakao{KEY}://oauth?code=...)은 KakaoSDK 가 처리한다.
    // oauth 콜백도 code 파라미터를 갖고 있어, host 로 거르지 않으면 인가 코드를
    // 초대코드로 오인해 참여 화면으로 튕긴다. (로그인과 같은 스킴·host 만 다름)
    if (uri.scheme.startsWith('kakao') && uri.host == 'oauth') return;

    // (A) invite_code / (B) code 둘 다 지원.
    final code =
        uri.queryParameters['invite_code'] ?? uri.queryParameters['code'];
    if (code != null && code.isNotEmpty) {
      onInvite(code);
    }
  }

  void dispose() {
    _subscription?.cancel();
    _subscription = null;
  }
}
