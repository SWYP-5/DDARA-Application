import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 프로필 화면에 표시할 사용자 정보.
class Profile {
  const Profile({required this.name, required this.joinedAt});

  /// 사용자 이름(닉네임).
  final String name;

  /// 가입일.
  final DateTime joinedAt;
}

/// 프로필 화면에 주입할 사용자 정보.
///
/// TODO: 실제 사용자 API/Repository 연동 후 더미 데이터를 대체한다.
final profileProvider = Provider<Profile>((ref) {
  return Profile(name: '따라쟁이', joinedAt: DateTime(2026, 6, 16));
});

/// 앱 버전. (예: 'v1.0.0')
///
/// TODO: package_info_plus 등으로 실제 빌드 버전을 읽어 대체한다.
final appVersionProvider = Provider<String>((ref) {
  return 'v1.0.0';
});

/// 연동된 소셜 계정 이름. (예: '카카오')
///
/// TODO: 실제 로그인한 소셜 계정 정보와 연동한다. (현재는 더미)
final linkedAccountProvider = Provider<String>((ref) {
  return '카카오';
});