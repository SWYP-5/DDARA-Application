import 'package:ddara/core/model/camera/starter_upload.dart';

abstract interface class CameraRepository {
  Future<StarterUpload> uploadStarter(int groupId, String topic, String path);
}
