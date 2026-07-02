import 'package:ddara/domain/repository/camera_repository.dart';

import '../../../core/model/camera/starter_upload.dart';

class StarterUploadUseCase {
  StarterUploadUseCase(this._cameraRepository);

  final CameraRepository _cameraRepository;

  Future<StarterUpload> call(
    int groupId,
    String topic,
    String path,
  ) async {
    return await _cameraRepository.uploadStarter(groupId, topic, path);
  }
}
