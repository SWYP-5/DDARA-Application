import 'package:ddara/core/model/profile/profile.dart';
import 'package:ddara/core/network/dto/profile/profile_response.dart';

extension ProfileMapper on ProfileResponse {
  Profile toDomain() {
    return Profile(
      id: id,
      name: name,
      profileImageUrl: profileImageUrl,
      provider: provider,
      createdAt: createdAt,
    );
  }
}