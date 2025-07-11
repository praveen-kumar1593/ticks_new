import 'dart:convert';

import 'package:get/get.dart';

import '../models/user_data_singleton.dart';
import '../models/nectar_app_theme.dart';
import '../models/api_response.dart';
import '../services/api_services.dart';
import '../services/storage_services.dart';
import '../utils/float_bottom_nav_bar_constant.dart';
import '../utils/share_pref_cache.dart';
import '../constants/custom_snackbar.dart';


class MainController extends GetxController {
  RxInt selectedIndex = 0.obs;
  UserDataSingleton? userData;
  List<BottomNavItem> permittedItems = [];
  final ApiServices _apiServices = ApiServices();
  final SharePrefCache _cache = SharePrefCache();
  final RxString themeLoadError = ''.obs;
  
  @override
  void onInit() {
    print('🔵 MainController onInit() called');
    userData = Get.find<UserDataSingleton>();
    print('MainController: userData = \\${userData?.toJson()}');
    // Debug: Call testDirectGraphQL once per app run
    if (!_hasCalledTestDirectGraphQL) {
      _hasCalledTestDirectGraphQL = true;
      Get.find<ApiServices>().testDirectGraphQL();
    }
    if (userData == null) {
      print("❌ User data is missing!");
      // Optionally, handle navigation or fallback here
    } else {
      print('🔵 User data found - Domain: \\${userData!.domain}');
      // If domain is available, call getAppTheme immediately
      if (userData!.domain.isNotEmpty) {
        print('🔵 Domain available, checking token before getAppTheme()');
      //  _checkTokenAndFetchTheme();
      } else {
        print('🔵 Domain not available yet, will retry later');
        // Retry after a short delay
        Future.delayed(const Duration(seconds: 2), () {
          if (userData?.domain.isNotEmpty == true) {
            print('🔵 Retrying getAppTheme() with domain: \\${userData!.domain} (commented out)');
            //_checkTokenAndFetchTheme();
          }
        });
      }
    }
    // Restore permittedItems logic
    permittedItems = FloatBottomNavBarConstant.bottomNavItems.where((item) => item.viewPermission).toList();
    print('MainController: permittedItems after init = \\${permittedItems.map((i) => i.title).toList()}');
    if (permittedItems.isNotEmpty) {
      selectedIndex.value = permittedItems[0].id;
      print('MainController: selectedIndex set to \\${selectedIndex.value}');
    } else {
      print('MainController: permittedItems is empty after init');
    }
    print('🔵 Calling _initializeNavigation()');
    super.onInit();
  }

  void _initializeNavigation() {
    print('MainController: _initializeNavigation called');
    // Start with all items permitted, will be filtered by app theme
    permittedItems = FloatBottomNavBarConstant.bottomNavItems.where((item) => item.viewPermission).toList();
    print('MainController: permittedItems after init = \\${permittedItems.map((i) => i.title).toList()}');
    if (permittedItems.isNotEmpty) {
      selectedIndex.value = permittedItems[0].id;
      print('MainController: selectedIndex set to \\${selectedIndex.value}');
    } else {
      print('MainController: permittedItems is empty after init');
    }
  }

  // Future<void> getAppTheme() async {
  //   print('🔵 getAppTheme() called');
  //   themeLoadError.value = '';
  //   if (userData?.domain == null || userData!.domain.isEmpty) {
  //     print('❌ userData.domain is null or empty, returning early');
  //     themeLoadError.value = 'Domain not specified. Please check your login or user data.';
  //     return;
  //   }
  //   print('🔵 Fetching app theme for domain: \\${userData!.domain}');
  //   final appTheme = await _apiServices.getFormTemplate(
  //     domain: userData!.domain,
  //     name: "APP_THEME"
  //   );
  //   print('🔵 API response received:');
  //   print('Success: \\${appTheme.success}');
  //   print('Data: \\${appTheme.data}');
  //   print('Error: \\${appTheme.error}');
  //   if (appTheme.success) {
  //     try {
  //       final appThemeData = appTheme.data;
  //       if (appThemeData != null && appThemeData.getFormTemplate != null) {
  //         final getFormTemplateResult = appThemeData.getFormTemplate;
  //         // Convert JsonObject to Map<String, dynamic>
  //         final getFormTemplateMap = jsonDecode(jsonEncode(getFormTemplateResult)) as Map<String, dynamic>;
  //         final formTemplateData = getFormTemplateMap['data'];
  //         if (formTemplateData == null) {
  //           print('❌ "data" field is missing inside getFormTemplate response.');
  //           themeLoadError.value = 'App theme response is missing the "data" field.';
  //           return;
  //         }
  //
  //         print('🔵 Form template data: $formTemplateData');
  //         NectarAppTheme appThemeModel = nectarAppThemeFromJson(
  //           jsonEncode(formTemplateData)
  //         );
  //         await _cache.saveMap(ShareprefConstant.appTheme, appThemeModel.toJson());
  //         _updateNavigationFromTheme(appThemeModel);
  //         themeLoadError.value = '';
  //       } else {
  //         print('❌ appThemeData or getFormTemplate is null');
  //         themeLoadError.value = 'App theme data is missing from the server response.';
  //       }
  //     } catch (e) {
  //       print("❌ Error parsing app theme: $e");
  //       themeLoadError.value = 'Error parsing app theme: $e';
  //     }
  //   } else {
  //     print("❌ Failed to load app theme: \\${appTheme.error}");
  //     themeLoadError.value = appTheme.error?.toString() ?? 'Unknown error loading app theme.';
  //   }
  // }

  // void _updateNavigationFromTheme(NectarAppTheme appTheme) {
  //   print('🔵 Updating navigation from theme data');
  //   print('🔵 App theme data: \\${appTheme.toJson()}');
  //
  //   // Extract permissions from the actual data structure
  //   List<String> permissions = [];
  //
  //   if (appTheme.asMap != null) {
  //     final data = appTheme.asMap!;
  //
  //     // Extract permissions from HOME_NEW.PERMISSIONS
  //     if (data['HOME_NEW'] != null &&
  //         data['HOME_NEW']['PERMISSIONS'] != null) {
  //       final homePermissions = data['HOME_NEW']['PERMISSIONS'];
  //       if (homePermissions['INIT_HOME_SCREEN_FEATURE'] != null) {
  //         permissions.add(homePermissions['INIT_HOME_SCREEN_FEATURE']);
  //       }
  //       if (homePermissions['INIT_HOME_SCREEN_FEATURE_GROUP'] != null) {
  //         permissions.add(homePermissions['INIT_HOME_SCREEN_FEATURE_GROUP']);
  //       }
  //     }
  //
  //     // Extract permissions from HOME.PERMISSIONS
  //     if (data['HOME'] != null &&
  //         data['HOME']['PERMISSIONS'] != null) {
  //       final homePermissions = data['HOME']['PERMISSIONS'];
  //       if (homePermissions['INIT_HOME_SCREEN_FEATURE'] != null) {
  //         permissions.add(homePermissions['INIT_HOME_SCREEN_FEATURE']);
  //       }
  //       if (homePermissions['INIT_HOME_SCREEN_FEATURE_GROUP'] != null) {
  //         permissions.add(homePermissions['INIT_HOME_SCREEN_FEATURE_GROUP']);
  //       }
  //     }
  //   }
  //
  //   print('🔵 Extracted permissions: $permissions');
  //
  //   // Filter navigation items based on permissions
  //   permittedItems = FloatBottomNavBarConstant.bottomNavItems.where((item) {
  //     // Check if user has permission for this navigation item
  //     switch (item.title.toLowerCase()) {
  //       case 'home':
  //         return permissions.contains('home') ||
  //                permissions.contains('jobInsights') ||
  //                permissions.contains('jobManagement');
  //       case 'history':
  //         return permissions.contains('attendance_history') ||
  //                permissions.contains('history') ||
  //                permissions.contains('view');
  //       case 'profile':
  //         return permissions.contains('profile') ||
  //                permissions.contains('user_profile') ||
  //                permissions.contains('view');
  //       case 'settings':
  //         return permissions.contains('settings') ||
  //                permissions.contains('admin') ||
  //                permissions.contains('manage');
  //       default:
  //         return true; // Default to showing if no specific permission check
  //     }
  //   }).toList();
  //
  //   print('🔵 Permitted navigation items: \\${permittedItems.map((item) => item.title).toList()}');
  //
  //   // Ensure we have at least one item
  //   if (permittedItems.isEmpty) {
  //     permittedItems = [FloatBottomNavBarConstant.bottomNavItems.first];
  //     print('🔵 No permissions found, using default navigation');
  //   }
  //
  //   // Update selected index if current selection is not in permitted items
  //   if (!permittedItems.any((item) => item.id == selectedIndex.value)) {
  //     selectedIndex.value = permittedItems.first.id;
  //     print('MainController: selectedIndex updated to \\${selectedIndex.value}');
  //   }
  // }

  // Public method to manually trigger app theme fetch (for testing)
  Future<void> refreshAppTheme() async {
    print('🔵 Manual app theme refresh triggered (getAppTheme commented out)');
    // await getAppTheme();
  }

  Future<void> _checkTokenAndFetchTheme() async {
    final storageService = Get.find<StorageService>();
    final token = await storageService.getAuthToken();
    print('MainController: Token before getAppTheme: $token');
    if (token == null || token.isEmpty) {
      print('MainController: Token is missing or empty, skipping getAppTheme call.');
      return;
    }
    print('MainController: Token is present, calling getAppTheme.');
    // Uncomment the next line to enable theme fetch when token is present
    // await getAppTheme();
  }

  static bool _hasCalledTestDirectGraphQL = false;
} 