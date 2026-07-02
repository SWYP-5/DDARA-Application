import 'package:ddara/core/model/camera/starter_upload.dart';
import 'package:ddara/core/model/group/cycle_gallery.dart';

abstract interface class CameraRepository {
  Future<StarterUpload> uploadStarter(int groupId, String topic, String path);

  Future<CycleGallery> getCycleGallery(int cycleId);
}
