import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../constants/r_colors.dart';
import '../constants/custom_text_style.dart';
import '../controllers/attendance_controller.dart';
import '../modules/geofence/location_history.dart';
import '../services/shared_preferences_services.dart';
import '../services/biometric/biometric_preference.dart';
import '../services/biometric/biomertic_sheet.dart';
import 'package:local_auth/local_auth.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _biometricEnabled = false;
  bool _deviceSupported = false;
  bool _canCheckBiometrics = false;
  List<BiometricType> _availableBiometrics = [];
  String? _currentLanguageCode;
  final List<Map<String, String>> _languages = [
    {'code': 'en', 'label': 'English'},
    {'code': 'hi', 'label': 'Hindi'},
    {'code': 'ta', 'label': 'Tamil'},
    {'code': 'te', 'label': 'Telugu'},
    {'code': 'ar', 'label': 'Arabic'},
    // Add more languages as needed
  ];

  @override
  void initState() {
    super.initState();
    _loadBiometricStatus();
    _checkDeviceCompatibility();
    _loadCurrentLanguage();
  }

  Future<void> _loadBiometricStatus() async {
    final enabled = await BiometricPreference.getBiometricEnabled();
    setState(() {
      _biometricEnabled = enabled ?? false;
    });
  }

  Future<void> _checkDeviceCompatibility() async {
    final LocalAuthentication auth = LocalAuthentication();
    try {
      final isDeviceSupported = await auth.isDeviceSupported();
      final canCheckBiometrics = await auth.canCheckBiometrics;
      final availableBiometrics = await auth.getAvailableBiometrics();
      
      setState(() {
        _deviceSupported = isDeviceSupported;
        _canCheckBiometrics = canCheckBiometrics;
        _availableBiometrics = availableBiometrics;
      });
    } catch (e) {
      print('[SettingsScreen] Error checking device compatibility: $e');
    }
  }

  Future<void> _loadCurrentLanguage() async {
    final lang = await SharedPrefrencesServices().getData(key: 'language');
    setState(() {
      _currentLanguageCode = lang ?? 'en';
    });
  }

  String _getBiometricStatusText() {
    if (!_deviceSupported) {
      return 'Device not supported';
    }
    if (!_canCheckBiometrics) {
      return 'Biometric hardware not available';
    }
    if (_availableBiometrics.isEmpty) {
      return 'No biometrics enrolled';
    }
    if (_biometricEnabled) {
      return 'Enabled - App requires biometric authentication';
    }
    return 'Disabled - No authentication required';
  }

  Color _getBiometricStatusColor() {
    if (!_deviceSupported || !_canCheckBiometrics || _availableBiometrics.isEmpty) {
      return Colors.orange;
    }
    if (_biometricEnabled) {
      return Colors.green;
    }
    return Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    final AttendanceController attendanceController = Get.find<AttendanceController>();
    
    return Scaffold(
      backgroundColor: RColors.backGroundGrey,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: _buildSettingsContent(context, attendanceController),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      color: RColors.orange,
      padding: const EdgeInsets.only(top: 24, left: 16, right: 16, bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.settings,
                color: RColors.pureWhite,
                size: 28,
              ),
              const SizedBox(width: 12),
              Text(
                'Settings',
                style: CustomTextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: RColors.pureWhite,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Customize your app experience',
            style: CustomTextStyle(
              fontSize: 16,
              color: RColors.pureWhite.withOpacity(0.9),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsContent(BuildContext context, AttendanceController attendanceController) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // _buildSettingsSection(
          //   'Notifications',
          //   [
          //     _buildSettingsItem(
          //       icon: Icons.notifications_outlined,
          //       title: 'Push Notifications',
          //       subtitle: 'Receive attendance reminders',
          //       trailing: Switch(
          //         value: true,
          //         onChanged: (value) {
          //           // TODO: Handle notification toggle
          //         },
          //         activeColor: RColors.orange,
          //       ),
          //     ),
          //     // Spoken Notifications Toggle
          //     FutureBuilder<String?>(
          //       future: SharedPrefrencesServices().getData(key: 'spoken_notifications'),
          //       builder: (context, snapshot) {
          //         final isEnabled = (snapshot.data ?? 'true') == 'true';
          //         return _buildSettingsItem(
          //           icon: Icons.record_voice_over,
          //           title: 'Spoken Notifications',
          //           subtitle: 'Hear notifications read aloud',
          //           trailing: Switch(
          //             value: isEnabled,
          //             onChanged: (value) async {
          //               SharedPrefrencesServices().saveData(
          //                 key: 'spoken_notifications',
          //                 value: value ? 'true' : 'false',
          //               );
          //               (context as Element).markNeedsBuild();
          //             },
          //             activeColor: RColors.orange,
          //           ),
          //         );
          //       },
          //     ),
          //     _buildSettingsItem(
          //       icon: Icons.schedule,
          //       title: 'Reminder Time',
          //       subtitle: 'Set check-in/check-out reminders',
          //       onTap: () {
          //         // TODO: Navigate to reminder settings
          //       },
          //     ),
          //   ],
          // ),
          const SizedBox(height: 16),
          _buildSettingsSection(
            'Location',
            [
              _buildSettingsItem(
                icon: Icons.location_on_outlined,
                title: 'Location Services',
                subtitle: 'Enable GPS for attendance',
                trailing: Switch(
                  value: true,
                  onChanged: (value) {
                    // TODO: Handle location toggle
                  },
                  activeColor: RColors.orange,
                ),
              ),
              _buildSettingsItem(
                icon: Icons.gps_fixed,
                title: 'Geofencing',
                subtitle: 'Automatic attendance at office',
                trailing: Switch(
                  value: true,
                  onChanged: (value) {
                    // TODO: Handle geofencing toggle
                  },
                  activeColor: RColors.orange,
                ),
              ),
              _buildSettingsItem(
                icon: Icons.location_searching,
                title: 'Background Location',
                subtitle: 'Track location when app is closed',
                trailing: FutureBuilder<bool>(
                  future: _getTrackingStatus(),
                  builder: (context, snapshot) {
                    final isTracking = snapshot.data ?? false;
                    return Switch(
                      value: isTracking,
                      onChanged: (value) async {
                        if (value) {
                          await attendanceController.startBackgroundLocationTracking();
                        } else {
                          await attendanceController.stopBackgroundLocationTracking();
                        }
                        // Refresh the UI
                        (context as Element).markNeedsBuild();
                      },
                      activeColor: RColors.orange,
                    );
                  },
                ),
              ),
              _buildSettingsItem(
                icon: Icons.analytics,
                title: 'Tracking Statistics',
                subtitle: 'View background tracking stats',
                onTap: () async {
                  final stats = await attendanceController.getTrackingStats();
                  _showTrackingStatsDialog(context, stats);
                },
              ),
              _buildSettingsItem(
                icon: Icons.history,
                title: 'Location History',
                subtitle: 'View your location tracking history',
                onTap: () async {
                  final locationHistory = await attendanceController.getLocationHistory();
                  _showLocationHistoryDialog(context, locationHistory);
                },
              ),
              // _buildSettingsItem(
              //   icon: Icons.history,
              //   title: 'Location History',
              //   subtitle: 'View your location tracking history',
              //   onTap: () async {
              //     final locationHistory = await attendanceController.getLocationHistory(); // List<Map<String, dynamic>>
              //     final latLngList = locationHistory
              //         .map((e) => LatLng(e['latitude'], e['longitude']))
              //         .toList();
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (_) => LocationHistoryMapScreen(locationHistory: latLngList),
              //       ),
              //     );
              //   },
              // ),
              _buildSettingsItem(
                icon: Icons.fence,
                title: 'Geofence Events',
                subtitle: 'View geofence entry/exit events',
                onTap: () async {
                  final geofenceEvents = await attendanceController.getGeofenceEvents();
                  _showGeofenceEventsDialog(context, geofenceEvents);
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildSettingsSection(
            'App',
            [
              _buildSettingsItem(
                icon: Icons.info_outline,
                title: 'About',
                subtitle: 'App version and information',
                onTap: () {
                  // TODO: Navigate to about screen
                },
              ),
              _buildSettingsItem(
                icon: Icons.help_outline,
                title: 'Help & Support',
                subtitle: 'Get help and contact support',
                onTap: () {
                  // TODO: Navigate to help screen
                },
              ),
              _buildSettingsItem(
                icon: Icons.privacy_tip_outlined,
                title: 'Privacy Policy',
                subtitle: 'Read our privacy policy',
                onTap: () {
                  // TODO: Navigate to privacy policy
                },
              ),
              _buildSettingsItem(
                icon: Icons.description_outlined,
                title: 'Terms of Service',
                subtitle: 'Read our terms of service',
                onTap: () {
                  // TODO: Navigate to terms of service
                },
              ),
            ],
          ),
          // Biometric Settings Section
          Card(
            margin: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Security',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.fingerprint,
                    color: _getBiometricStatusColor(),
                  ),
                  title: const Text('Biometric Authentication'),
                  subtitle: Text(_getBiometricStatusText()),
                  trailing: Switch(
                    value: _biometricEnabled,
                    onChanged: (_deviceSupported && _canCheckBiometrics && _availableBiometrics.isNotEmpty) 
                        ? (value) async {
                            if (value) {
                              // Show biometric setup
                              showEnableBiometricSheet(
                                context,
                                onEnabled: () {
                                  setState(() {
                                    _biometricEnabled = true;
                                  });
                                  Get.snackbar(
                                    'Success',
                                    'Biometric authentication enabled',
                                    backgroundColor: Colors.green,
                                    colorText: Colors.white,
                                  );
                                },
                              );
                            } else {
                              // Disable biometric
                              await BiometricPreference.setBiometricEnabled(false);
                              setState(() {
                                _biometricEnabled = false;
                              });
                              Get.snackbar(
                                'Success',
                                'Biometric authentication disabled',
                                backgroundColor: Colors.orange,
                                colorText: Colors.white,
                              );
                            }
                          }
                        : null, // Disable switch if device not supported
                  ),
                ),
                if (!_deviceSupported || !_canCheckBiometrics || _availableBiometrics.isEmpty)
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.orange.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.orange.withOpacity(0.3)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Device Compatibility',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text('Device supported: $_deviceSupported'),
                          Text('Can check biometrics: $_canCheckBiometrics'),
                          Text('Available biometrics: ${_availableBiometrics.map((e) => e.name).join(', ')}'),
                          const SizedBox(height: 8),
                          const Text(
                            'To use biometric authentication, your device must support fingerprint or face recognition and have it properly configured.',
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
          
          // Other settings sections can go here
          Card(
            margin: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'App Settings',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.notifications),
                  title: const Text('Notifications'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // Navigate to notifications settings
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.language),
                  title: const Text('Language'),
                  subtitle: Text(_languages.firstWhere((lang) => lang['code'] == _currentLanguageCode, orElse: () => _languages[0])['label']!),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () => _showLanguagePicker(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsSection(String title, List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: RColors.pureWhite,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              title,
              style: CustomTextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: RColors.black,
              ),
            ),
          ),
          ...children,
        ],
      ),
    );
  }

  Widget _buildSettingsItem({
    required IconData icon,
    required String title,
    required String subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: RColors.orange,
        size: 24,
      ),
      title: Text(
        title,
        style: CustomTextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: RColors.black,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: CustomTextStyle(
          fontSize: 14,
          color: RColors.fadedGreyText,
        ),
      ),
      trailing: trailing ?? (onTap != null ? Icon(
        Icons.arrow_forward_ios,
        color: RColors.darkGrey,
        size: 16,
      ) : null),
      onTap: onTap,
    );
  }

  void _showLocationHistoryDialog(BuildContext context, List<Map<String, dynamic>> locationHistory) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Location History',
            style: CustomTextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: RColors.black,
            ),
          ),
          content: SizedBox(
            width: double.maxFinite,
            height: 400,
            child: locationHistory.isEmpty
                ? Center(
                    child: Text(
                      'No location history available',
                      style: CustomTextStyle(
                        fontSize: 16,
                        color: RColors.fadedGreyText,
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: locationHistory.length,
                    itemBuilder: (context, index) {
                      final location = locationHistory[index];
                      final timestamp = location['timestamp'] != null
                          ? DateTime.fromMillisecondsSinceEpoch(location['timestamp'])
                          : DateTime.now();
                      
                      return ListTile(
                        leading: Icon(Icons.location_on, color: RColors.orange),
                        title: Text(
                          '${location['latitude']?.toStringAsFixed(6)}, ${location['longitude']?.toStringAsFixed(6)}',
                          style: CustomTextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: RColors.black,
                          ),
                        ),
                        subtitle: Text(
                          '${timestamp.day}/${timestamp.month}/${timestamp.year} ${timestamp.hour}:${timestamp.minute}',
                          style: CustomTextStyle(
                            fontSize: 12,
                            color: RColors.fadedGreyText,
                          ),
                        ),
                        trailing: Text(
                          '${location['accuracy']?.toStringAsFixed(1)}m',
                          style: CustomTextStyle(
                            fontSize: 12,
                            color: RColors.orange,
                          ),
                        ),
                      );
                    },
                  ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Close',
                style: CustomTextStyle(
                  fontSize: 16,
                  color: RColors.orange,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showGeofenceEventsDialog(BuildContext context, List<Map<String, dynamic>> geofenceEvents) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Geofence Events',
            style: CustomTextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: RColors.black,
            ),
          ),
          content: SizedBox(
            width: double.maxFinite,
            height: 400,
            child: geofenceEvents.isEmpty
                ? Center(
                    child: Text(
                      'No geofence events available',
                      style: CustomTextStyle(
                        fontSize: 16,
                        color: RColors.fadedGreyText,
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: geofenceEvents.length,
                    itemBuilder: (context, index) {
                      final event = geofenceEvents[index];
                      final timestamp = event['timestamp'] != null
                          ? DateTime.fromMillisecondsSinceEpoch(event['timestamp'])
                          : DateTime.now();
                      
                      return ListTile(
                        leading: Icon(
                          event['isInside'] == true ? Icons.login : Icons.logout,
                          color: event['isInside'] == true ? Colors.green : Colors.red,
                        ),
                        title: Text(
                          event['geofenceName'] ?? 'Unknown Location',
                          style: CustomTextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: RColors.black,
                          ),
                        ),
                        subtitle: Text(
                          '${event['isInside'] == true ? 'Entered' : 'Left'} • ${timestamp.day}/${timestamp.month}/${timestamp.year} ${timestamp.hour}:${timestamp.minute}',
                          style: CustomTextStyle(
                            fontSize: 12,
                            color: RColors.fadedGreyText,
                          ),
                        ),
                        trailing: Text(
                          '${event['distance']?.toStringAsFixed(1)}m',
                          style: CustomTextStyle(
                            fontSize: 12,
                            color: RColors.orange,
                          ),
                        ),
                      );
                    },
                  ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Close',
                style: CustomTextStyle(
                  fontSize: 16,
                  color: RColors.orange,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<bool> _getTrackingStatus() async {
    try {
      final attendanceController = Get.find<AttendanceController>();
      final stats = await attendanceController.getTrackingStats();
      return stats['isTracking'] ?? false;
    } catch (e) {
      print('Error getting tracking status: $e');
      return false;
    }
  }

  void _showTrackingStatsDialog(BuildContext context, Map<String, dynamic> stats) {
    final isTracking = stats['isTracking'] ?? false;
    final totalLocations = stats['totalLocations'] ?? 0;
    final totalGeofenceEvents = stats['totalGeofenceEvents'] ?? 0;
    final trackingDuration = stats['trackingDuration'] ?? 0;
    final lastUpdateTime = stats['lastUpdateTime'];
    
    final duration = Duration(milliseconds: trackingDuration);
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    
    final lastUpdate = lastUpdateTime != null 
        ? DateTime.fromMillisecondsSinceEpoch(lastUpdateTime)
        : null;
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Tracking Statistics',
            style: CustomTextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: RColors.black,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildStatRow('Status', isTracking ? 'Active' : 'Inactive', 
                  isTracking ? Colors.green : Colors.red),
              _buildStatRow('Total Locations', totalLocations.toString(), RColors.orange),
              _buildStatRow('Geofence Events', totalGeofenceEvents.toString(), RColors.orange),
              _buildStatRow('Tracking Duration', '${hours}h ${minutes}m', RColors.orange),
              if (lastUpdate != null)
                _buildStatRow('Last Update', 
                    '${lastUpdate.day}/${lastUpdate.month}/${lastUpdate.year} ${lastUpdate.hour}:${lastUpdate.minute}', 
                    RColors.orange),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Close',
                style: CustomTextStyle(
                  fontSize: 16,
                  color: RColors.orange,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
  
  Widget _buildStatRow(String label, String value, Color valueColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: CustomTextStyle(
              fontSize: 14,
              color: RColors.fadedGreyText,
            ),
          ),
          Text(
            value,
            style: CustomTextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }

  void _showLanguagePicker(BuildContext context) async {
    String? selected = await showDialog<String>(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('Select Language'),
        children: _languages.map((lang) {
          return SimpleDialogOption(
            onPressed: () => Navigator.pop(context, lang['code']),
            child: Text(lang['label']!),
          );
        }).toList(),
      ),
    );

    if (selected != null) {
      await SharedPrefrencesServices().setData('language', selected);
      Get.updateLocale(Locale(selected));
      setState(() {
        _currentLanguageCode = selected;
      });
    }
  }
} 