// import 'package:nectar_custom_pack/module/local_storage/share_pref_cache.dart';
// import 'package:nectar_custom_pack/module/local_storage/share_pref_constant_pkg.dart';
// import 'package:nectar_custom_pack/module/user_permission/user_permission.dart';
// import 'package:nectar_custom_pack/module/user_permission/user_permission_list.dart';
//
// class GlobalPermissions {
//   static final GlobalPermissions _instance = GlobalPermissions._internal();
//
//   late UserPermission userPermission;
//
//   factory GlobalPermissions() {
//     return _instance;
//   }
//
//   GlobalPermissions._internal();
//
//   void initialize({
//     String sharePrefKey = ShareprefConstantPkg.loginUserPermissionList,
//   }) {
//     final cache = SharePrefCache();
//
//     final loginPermissions =
//         (cache.getMap(
//           sharePrefKey,
//         ))?.map((key, value) => MapEntry(key, value as Object)) ??
//         {};
//     userPermission = UserPermission(
//       userPermissionsList: userPermissionsList,
//       loginPermissions: loginPermissions,
//     );
//   }
// }
