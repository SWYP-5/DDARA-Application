import 'package:ddara/core/auth/google_auth_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final googleAuthProvider = Provider<GoogleAuthService>((ref) {
  return GoogleAuthService();
});
