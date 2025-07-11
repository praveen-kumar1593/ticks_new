

import '../helpers/r_logger_helper.dart';

class UserPermission {
  final List<Map<String, dynamic>> userPermissionsList;
  final Map<String, dynamic> loginPermissions;

  UserPermission({
    required this.userPermissionsList,
    required this.loginPermissions,
  });

  bool hasPermission({
    required String featureGroupName,
    required String featureName,
    required String permissionName,
  }) {
    try {
      // Find the feature group by name
      var featureGroup = userPermissionsList.firstWhere(
        (f) => f["name"] == featureGroupName,
        orElse: () => <String, dynamic>{}, // ✅ Fix here
      );

      if (featureGroup.isEmpty) {
        RLoggerHelper.warning(
          "❌ ERROR: Feature '$featureGroupName' not found.",
        );
        return false;
      }

      // Check if the feature group is in the login permissions
      if (!loginPermissions["featureGroupCodes"].contains(
        featureGroup["accessCode"],
      )) {
        RLoggerHelper.warning(
          "❌ ERROR: Feature '$featureName' not allowed for this user.",
        );
        return false;
      }

      // Find the feature in the feature group
      var features = featureGroup["features"] as List<dynamic>? ?? [];
      var feature = features.firstWhere(
        (f) => f["name"] == featureName,
        orElse: () => <String, Object>{}, // ✅ Fix here
      );

      if (feature.isEmpty) {
        RLoggerHelper.warning(
          "❌ ERROR: Feature '$featureName' not found in feature group.",
        );
        return false;
      }

      // Check if the feature is in the login permissions
      if (!loginPermissions["featureCodes"].contains(feature["accessCode"])) {
        RLoggerHelper.warning(
          "❌ ERROR: Feature '$featureName' not allowed for this user.",
        );
        return false;
      }

      // Find the permission in the feature
      var permissions = feature["permissions"] as List<dynamic>? ?? [];
      var permission = permissions.firstWhere(
        (p) => p["name"] == permissionName,
        orElse: () => <String, String>{}, // ✅ Fix here
      );

      if (permission.isEmpty) {
        RLoggerHelper.warning(
          "❌ ERROR: Permission '$permissionName' not found in feature '$featureName'.",
        );
        return false;
      }

      // Check if the permission is in the login permissions
      return loginPermissions["permissionCodes"].contains(
        permission["accessCode"],
      );
    } catch (e) {
      RLoggerHelper.warning("⚠️ EXCEPTION: An error occurred - $e");
      return false;
    }
  }
}
