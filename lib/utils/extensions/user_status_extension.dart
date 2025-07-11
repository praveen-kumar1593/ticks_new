import '../user_status_enum.dart';

extension UserStatusExtension on UserStatus {
  bool get isOnline => this == UserStatus.Online;
} 