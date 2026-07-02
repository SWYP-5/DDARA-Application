import 'package:ddara/core/model/profile/profile.dart';
import 'package:ddara/domain/repository/profile_repository.dart';

class GetProfileUseCase {
  GetProfileUseCase(this._profileRepository);
  final ProfileRepository _profileRepository;

  Future<Profile> call() async {
    final test = await _profileRepository.getProfile();
    print("테스트 프로필 : $test");
    return test;
  }
}
