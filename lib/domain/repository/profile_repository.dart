import 'package:ddara/core/model/profile/profile.dart';

abstract interface class ProfileRepository {
  Future<Profile> getProfile();
}
