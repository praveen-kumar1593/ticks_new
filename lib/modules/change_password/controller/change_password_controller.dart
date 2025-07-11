import 'package:ticks_new/services/graphql_client_services.dart';
import 'package:ferry/ferry.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../constants/custom_snackbar.dart';
import '../../../graphql/__generated__/change_password.req.gql.dart';
import '../../../utils/exception/r_exception.dart';
import '../../logout/method/logout.dart';


class ChangePasswordController extends GetxController {
  final Client ferryClient = Get.find<GraphQLClientService>().client;
  final GlobalKey<FormState> changePasswordFormKey = GlobalKey<FormState>();

  final TextEditingController oldPassword = TextEditingController();
  final TextEditingController newPassword = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();

  RxBool isChangePasswordLoading = false.obs;

  RxBool isOldPasswordVisible = true.obs;
  RxBool isNewPasswordVisible = true.obs;
  RxBool isConfirmPasswordVisible = true.obs;

  Future<void> updatePassword() async {
    try {
      isChangePasswordLoading.value = true;
      final changePassVar = GchangePasswordReq(
        (b) =>
            b
              ..vars.newPassword = newPassword.text
              ..vars.password = oldPassword.text,
      );
      final response = await ferryClient.request(changePassVar).first;

      if (!response.hasErrors) {
        final status = response.data!.changePassword?.asMap['status'];
        if (status == "SUCCESS") {
          rShowCustomSnackbar(message: "Password updated successfully", snackbarType: SnackbarType.success);
          RLogout.loggedOut();
        } else {
          rShowCustomSnackbar(message: "Password update failed", snackbarType: SnackbarType.error);
        }
      } else {
        RException.errorHandler(erroMessage: "❌ GraphQL Errors updatePassword: ${response.graphqlErrors}");
      }
    } catch (e, stackTrace) {
      RException.exceptionHandler(exceptionMessage: "❌ Exception updatePassword: $e", stackTrace: stackTrace);
    } finally {
      isChangePasswordLoading.value = false;
    }
  }

  void clearAll() {
    oldPassword.clear();
    newPassword.clear();
    confirmPassword.clear();
  }
}
