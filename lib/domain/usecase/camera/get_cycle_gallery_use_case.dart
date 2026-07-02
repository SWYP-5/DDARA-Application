import 'package:ddara/domain/repository/camera_repository.dart';

import '../../../core/model/group/cycle_gallery.dart';

class GetCycleGalleryUseCase {
  GetCycleGalleryUseCase(this._cameraRepository);

  final CameraRepository _cameraRepository;

  Future<CycleGallery> call(int cycleId) async {
    return await _cameraRepository.getCycleGallery(cycleId);
  }
}
