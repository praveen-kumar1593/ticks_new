import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

import 'biometric_preference.dart';

Future<void> showEnableBiometricSheet(BuildContext context, {VoidCallback? onEnabled, VoidCallback? onSkipped}) async {
  print('[BiometricSheet] Showing enable biometric sheet...');
  final LocalAuthentication auth = LocalAuthentication();
  final availableBiometrics = await auth.getAvailableBiometrics();
  print('[BiometricSheet] Available biometrics: $availableBiometrics');
  final hasFace = availableBiometrics.contains(BiometricType.face);
  final hasFingerprint = availableBiometrics.contains(BiometricType.fingerprint);
  final hasStrong = availableBiometrics.contains(BiometricType.strong);
  final hasWeak = availableBiometrics.contains(BiometricType.weak);

  String getBiometricTitle() {
    if (hasFace && hasFingerprint) {
      return "Enable Face or Fingerprint Authentication";
    } else if (hasFace) {
      return "Enable Face Authentication";
    } else if (hasFingerprint) {
      return "Enable Fingerprint Authentication";
    } else if (hasStrong && hasWeak) {
      return "Enable Biometric Authentication";
    } else if (hasStrong) {
      return "Enable Biometric Authentication";
    } else if (hasWeak) {
      return "Enable Biometric Authentication";
    } else {
      return "Enable Biometric Authentication";
    }
  }

  String getBiometricDescription() {
    if (hasFace && hasFingerprint) {
      return "Secure your app with Face ID or fingerprint. Use your face or fingerprint for quick and safe access.";
    } else if (hasFace) {
      return "Secure your app with Face ID. Use your face for quick and safe access.";
    } else if (hasFingerprint) {
      return "Secure your app with fingerprint authentication. Use your fingerprint for quick and safe access.";
    } else if (hasStrong || hasWeak) {
      return "Secure your app with biometric authentication. Use your device's biometric sensor for quick and safe access.";
    } else {
      return "Secure your app with biometric authentication.";
    }
  }

  showModalBottomSheet(
    context: context,
    isDismissible: false,
    enableDrag: false,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
    ),
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (hasFace) Icon(Icons.face, size: 40, color: Colors.blue),
                if (hasFingerprint) ...[
                  if (hasFace) SizedBox(width: 16),
                  Icon(Icons.fingerprint, size: 40, color: Colors.blue),
                ],
                if (!hasFace && !hasFingerprint && (hasStrong || hasWeak))
                  Icon(Icons.verified_user, size: 40, color: Colors.blue),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              getBiometricTitle(),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              getBiometricDescription(),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    print('[BiometricSheet] Enable button pressed...');
                    // Check device compatibility first
                    try {
                      final isDeviceSupported = await auth.isDeviceSupported();
                      final canCheckBiometrics = await auth.canCheckBiometrics;
                      
                      print('[BiometricSheet] Device supported: $isDeviceSupported');
                      print('[BiometricSheet] Can check biometrics: $canCheckBiometrics');
                      
                      if (!isDeviceSupported) {
                        _showDeviceNotSupportedDialog(context);
                        return;
                      }
                      
                      if (!canCheckBiometrics) {
                        _showNoBiometricsDialog(context);
                        return;
                      }
                      
                      if (availableBiometrics.isEmpty) {
                        _showNoBiometricsEnrolledDialog(context);
                        return;
                      }
                      
                      print('[BiometricSheet] Starting authentication...');
                      final bool didAuthenticate = await auth.authenticate(
                        localizedReason: 'Please authenticate to enable biometric lock',
                        options: const AuthenticationOptions(biometricOnly: true),
                      );
                      print('[BiometricSheet] Authentication result: $didAuthenticate');
                      
                      if (didAuthenticate) {
                        print('[BiometricSheet] Authentication successful, saving preferences...');
                        await BiometricPreference.setBiometricEnabled(true);
                        await BiometricPreference.setBiometricSkip(false);
                        Navigator.pop(context);
                        if (onEnabled != null) onEnabled();
                      }
                    } catch (e) {
                      print('[BiometricSheet] Authentication error: $e');
                      _showErrorDialog(context, e.toString());
                    }
                  },
                  child: const Text("Enable"),
                ),
                TextButton(
                  onPressed: () async {
                    print('[BiometricSheet] Skip button pressed...');
                    await BiometricPreference.setBiometricSkip(true);
                    await BiometricPreference.setBiometricEnabled(false);
                    Navigator.pop(context);
                    if (onSkipped != null) onSkipped();
                  },
                  child: const Text("Skip"),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}

void _showDeviceNotSupportedDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Device Not Supported'),
      content: const Text('Your device does not support biometric authentication. This feature is only available on devices with fingerprint sensors or Face ID.'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('OK'),
        ),
      ],
    ),
  );
}

void _showNoBiometricsDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Biometric Authentication Not Available'),
      content: const Text('Biometric authentication is not available on this device. Please check your device settings or use a device with fingerprint/face recognition.'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('OK'),
        ),
      ],
    ),
  );
}

void _showNoBiometricsEnrolledDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('No Biometrics Enrolled'),
      content: const Text('Please set up fingerprint or face recognition in your device settings before enabling biometric authentication.'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('OK'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            // You can add navigation to device settings here if needed
          },
          child: const Text('Open Settings'),
        ),
      ],
    ),
  );
}

void _showErrorDialog(BuildContext context, String error) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Authentication Error'),
      content: Text('An error occurred: $error'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('OK'),
        ),
      ],
    ),
  );
}