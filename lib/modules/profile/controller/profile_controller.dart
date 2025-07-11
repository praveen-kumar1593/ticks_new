import 'package:built_value/json_object.dart';
import 'package:ferry/ferry.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:ticks_new/services/graphql_client_services.dart';

import '../../../constants/custom_snackbar.dart';
import '../../../graphql/__generated__/find_logged_in_user.req.gql.dart';
import '../../../graphql/__generated__/update_profile.req.gql.dart';
import '../../../utils/exception/r_exception.dart';
import '../../../utils/global_singletone/global_permission.dart';
import '../model/find_login_in_user.dart';
// Adjust path if needed

class ProfileController extends GetxController {
  final Rx<FindLoggedInUser?> profile = Rx<FindLoggedInUser?>(null);
  final Client ferryClient = Get.find<GraphQLClientService>().client;
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;
  RxBool isEditProfileLoading = false.obs;

  final TextEditingController firstName = TextEditingController();
  final TextEditingController lasttName = TextEditingController();
  final TextEditingController contactNumber = TextEditingController();
  final TextEditingController emailAddress = TextEditingController();

  final GlobalKey<FormState> profileFormKey = GlobalKey<FormState>();

  final bool nonEditablePermission =
  !GlobalPermissions().userPermission.hasPermission(
    featureGroupName: "applicationAccess",
    featureName: "login",
    permissionName: "mobile",
  );

  RxString username = RxString("");
  RxString roleName = RxString("");
  RxString domain = RxString("");
  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }

  Future<void> fetchProfile({int retryCount = 0}) async {
    isLoading.value = true;
    error.value = '';
    try {
      final client = Get.find<GraphQLClientService>().client;
      final req = GfindLoggedInUserReq();
      final response = await client.request(req).first;
      if (response.hasErrors) {
        error.value = response.graphqlErrors?.map((e) => e.message).join(', ') ?? 'Unknown error';
        profile.value = null;
        // Retry if unknown error and not exceeded max retries
        if (error.value == 'Unknown error' && retryCount < 3) {
          await Future.delayed(const Duration(seconds: 1));
          await fetchProfile(retryCount: retryCount + 1);
        }
        return;
      }
      final profileData = response.data?.findLoggedInUser?.value;
      if (profileData == null) {
        error.value = 'No profile data found.';
        profile.value = null;
        return;
      }
      profile.value = FindLoggedInUser.fromJson(profileData as Map<String, dynamic>);
    } catch (e) {
      error.value = e.toString();
      profile.value = null;
    } finally {
      isLoading.value = false;
    }
  }
  Future<void> updateProfileData() async {
    try {
      isEditProfileLoading.value = true;
      profile.value?.profileUser.data.firstName = firstName.text;
      profile.value?.profileUser.data.lastName = lasttName.text;
      profile.value?.profileUser.data.contactNumber = contactNumber.text;
      profile.value?.profileUser.data.emailId = emailAddress.text;

      final userData = profile.value?.profileUser.toJson();

      final updateProfileVar = GupdateProfileReq((b) => b..vars.user = JsonObject(userData));

      final response = await ferryClient.request(updateProfileVar).first;
      if (!response.hasErrors) {
        final updateProfileData = response.data?.updateProfile;

        if (updateProfileData != null) {
          final status = updateProfileData.asMap['status'];

          if (status == "SUCCESS") {
            rShowCustomSnackbar(message: "Profile updated successfully!", snackbarType: SnackbarType.success);

            await fetchProfile();
          } else {
            rShowCustomSnackbar(message: "Profile update Failed!", snackbarType: SnackbarType.error);
          }
        }
      } else {
        RException.errorHandler(erroMessage: "❌ GraphQL Errors updateProfileData: ${response.graphqlErrors}");
      }
    } catch (e, stackTrace) {
      RException.exceptionHandler(exceptionMessage: "❌ Exception updateProfileData: $e", stackTrace: stackTrace);
    } finally {
      isEditProfileLoading.value = false;
    }
  }

  void clearAllFeild() {
    firstName.clear();
    lasttName.clear();
    contactNumber.clear();
    emailAddress.clear();
  }
} 