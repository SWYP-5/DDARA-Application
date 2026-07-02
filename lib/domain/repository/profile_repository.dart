import 'package:ddara/core/model/profile/notification_settings.dart';
import 'package:ddara/core/model/profile/profile.dart';

abstract interface class ProfileRepository {
  Future<Profile> getProfile();

  Future<void> deleteAccount();

  Future<NotificationSettings> getNotificationSettings();

  Future<NotificationSettings> changeNotificationSettings(NotificationSettings settings);
}
