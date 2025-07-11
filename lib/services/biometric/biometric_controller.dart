import 'package:app_settings/app_settings.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_darwin/local_auth_darwin.dart';

class BiometricController extends GetxController {
  final RxBool isAuthenticated = false.obs;
  final bool isInit;
  final BuildContext context;

  final LocalAuthentication _auth = LocalAuthentication();

  BiometricController({this.isInit = false, required this.context});

  @override
  void onInit() {
    if (isInit) {
      authenticate();
    }

    super.onInit();
  }

  Future<bool> authenticate() async {
    if (!await hasBiometrics()) {
      // print('No biometrics available');
      showAdaptiveDialog(
        context: context,
        barrierDismissible: false,
        useSafeArea: true,
        builder: (context) => AlertDialog(
          title: const Text('No Device lock detected'),
          content: const Text('Please enable device lock'),
          icon: Icon(
            Icons.lock,
            color: Theme.of(context).primaryColor,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
            TextButton(
              onPressed: () => AppSettings.openAppSettings(
                  type: AppSettingsType.lockAndPassword),
              child: const Text('Open settings'),
            ),
          ],
        ),
      );
      return false;
    }

    if (!isAuthenticated.value) {
      debugPrint('Authenticating...');
      try {
        final bool didAuthenticate = await _auth.authenticate(
          localizedReason: 'Use biometrics or device lock to access',
          authMessages: const <AuthMessages>[
            AndroidAuthMessages(
              // signInTitle: 'Oops! Biometric authentication required!',
              goToSettingsButton: '',
              goToSettingsDescription:
              'Your device is not configured for biometric authentication.',
              cancelButton: 'Ok',
            ),
            IOSAuthMessages(
              goToSettingsButton: '',
              cancelButton: 'Ok',
            ),
          ],
          options: const AuthenticationOptions(
              biometricOnly: false, sensitiveTransaction: true),
        );
        isAuthenticated.value = didAuthenticate;
      } on PlatformException catch (e) {
        isAuthenticated.value = false;
        if (e.code == auth_error.notEnrolled) {
          debugPrint('Biometric authentication not Enrolled');
          //await AppSettings.openAppSettings(type: AppSettingsType.device);
        }
      } catch (e) {
        isAuthenticated.value = false;
        debugPrint("Biometric Authentication error: $e.");
      } finally {
        debugPrint('Authentication finished');
      }
    }
    return isAuthenticated.value;
  }

  Future<bool> hasBiometrics() async {
    final isAvailable = await _auth.canCheckBiometrics;
    final isDeviceSupported = await _auth.isDeviceSupported();
    return isAvailable && isDeviceSupported;
  }
}