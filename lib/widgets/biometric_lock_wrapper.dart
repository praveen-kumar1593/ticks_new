import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import '../services/biometric/biometric_preference.dart';

class BiometricLockWrapper extends StatefulWidget {
  final Widget child;
  final Widget? lockScreen;

  const BiometricLockWrapper({
    super.key,
    required this.child,
    this.lockScreen,
  });

  @override
  State<BiometricLockWrapper> createState() => _BiometricLockWrapperState();
}

class _BiometricLockWrapperState extends State<BiometricLockWrapper> with WidgetsBindingObserver {
  bool _isAuthenticated = false;
  bool _isLoading = true;
  bool _biometricEnabled = false;
  List<BiometricType> _availableBiometrics = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _checkBiometricStatus();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed && _biometricEnabled) {
      // Only re-authenticate if not already authenticated
      if (!_isAuthenticated) {
        setState(() {
          _isLoading = true;
        });
        await _authenticate();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    print('[BiometricLockWrapper] build: _isLoading=[32m[1m$_isLoading[0m, _isAuthenticated=[32m[1m$_isAuthenticated[0m');
    if (_isLoading) {
      print('[BiometricLockWrapper] Showing spinner');
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (!_isAuthenticated) {
      print('[BiometricLockWrapper] Showing lock screen');
      return widget.lockScreen ?? _defaultLockScreen();
    }

    print('[BiometricLockWrapper] Showing child');
    return widget.child;
  }

  Future<void> _checkBiometricStatus() async {
    final enabled = await BiometricPreference.getBiometricEnabled();
    final skip = await BiometricPreference.getBiometricSkip();
    print('[BiometricLockWrapper] _checkBiometricStatus: enabled=$enabled, skip=$skip');

    if (enabled == true) {
      final LocalAuthentication auth = LocalAuthentication();
      try {
        final isDeviceSupported = await auth.isDeviceSupported();
        final canCheckBiometrics = await auth.canCheckBiometrics;
        final availableBiometrics = await auth.getAvailableBiometrics();
        _availableBiometrics = availableBiometrics;
        print('[BiometricLockWrapper] Device supported: $isDeviceSupported, canCheckBiometrics: $canCheckBiometrics, availableBiometrics: $availableBiometrics');

        if (!isDeviceSupported || !canCheckBiometrics || availableBiometrics.isEmpty) {
          print('[BiometricLockWrapper] Device not supported or no biometrics enrolled, disabling biometric');
          await BiometricPreference.setBiometricEnabled(false);
          setState(() {
            _isAuthenticated = true;
            _isLoading = false;
            _biometricEnabled = false;
          });
          if (availableBiometrics.isEmpty) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
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
                  ],
                ),
              );
            });
          }
          return;
        }
        print('[BiometricLockWrapper] Proceeding to authenticate');
        await _authenticate();
      } catch (e) {
        print('[BiometricLockWrapper] Error checking biometric status: $e');
        await BiometricPreference.setBiometricEnabled(false);
        setState(() {
          _isAuthenticated = true;
          _isLoading = false;
          _biometricEnabled = false;
        });
      }
    } else if (skip == true) {
      print('[BiometricLockWrapper] Biometric skipped, letting user in');
      setState(() {
        _isAuthenticated = true;
        _isLoading = false;
        _biometricEnabled = false;
      });
    } else {
      print('[BiometricLockWrapper] Neither enabled nor skipped, letting user in');
      setState(() {
        _isAuthenticated = true;
        _isLoading = false;
        _biometricEnabled = false;
      });
    }
  }

  Future<void> _authenticate() async {
    final LocalAuthentication auth = LocalAuthentication();
    try {
      print('[BiometricLockWrapper] Starting authentication');
      final bool didAuthenticate = await auth.authenticate(
        localizedReason: 'Please authenticate to access the app',
        options: const AuthenticationOptions(biometricOnly: true),
      );
      print('[BiometricLockWrapper] Authentication result: $didAuthenticate');
      setState(() {
        _isAuthenticated = didAuthenticate;
        _isLoading = false;
      });
    } catch (e) {
      print('[BiometricLockWrapper] Authentication error: $e');
      setState(() {
        _isAuthenticated = false;
        _isLoading = false;
      });
    }
  }

  Widget _defaultLockScreen() {
    final hasFace = _availableBiometrics.contains(BiometricType.face);
    final hasFingerprint = _availableBiometrics.contains(BiometricType.fingerprint);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (hasFace) Icon(Icons.face, size: 60, color: Colors.blue),
                if (hasFingerprint) ...[
                  if (hasFace) SizedBox(width: 20),
                  Icon(Icons.fingerprint, size: 60, color: Colors.blue),
                ],
              ],
            ),
            const SizedBox(height: 20),
            Text(
              hasFace && hasFingerprint
                  ? 'Face or Fingerprint Authentication Required'
                  : hasFace
                      ? 'Face Authentication Required'
                      : 'Fingerprint Authentication Required',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Please authenticate to access the app',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: _authenticate,
              icon: Icon(
                hasFace
                    ? Icons.face
                    : Icons.fingerprint,
              ),
              label: const Text('Authenticate'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 