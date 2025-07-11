import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class BiometricService {
  static final LocalAuthentication _auth = LocalAuthentication();

  static Future<bool> checkAndAuthenticate({
    required BuildContext context,
    required VoidCallback onSuccess,
    String title = "Biometric Authentication",
    String content = "Please authenticate to continue",
  }) async {
    try {
      final canCheckBiometrics = await _auth.canCheckBiometrics;
      final isDeviceSupported = await _auth.isDeviceSupported();

      if (!canCheckBiometrics || !isDeviceSupported) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Biometric authentication not available on this device.')),
        );
        return false;
      }

      final didAuthenticate = await _auth.authenticate(
        localizedReason: content,
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
        ),
      );

      if (didAuthenticate) {
        onSuccess();
        return true;
      }
      return false;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Biometric error: $e')),
      );
      return false;
    }
  }
}

// Wrapper class for compatibility with your existing code
class BiometricFeature {
  final BuildContext context;
  final VoidCallback onSuccess;

  BiometricFeature({
    required this.context,
    required this.onSuccess,
  });

  Future<bool> checkAndAuthenticate() async {
    return await BiometricService.checkAndAuthenticate(
      context: context,
      onSuccess: onSuccess,
    );
  }
}