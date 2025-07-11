// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:attendance/controllers/attendance_controller.dart';
// import 'package:attendance/controllers/auth_controller.dart';
// import 'package:attendance/utils/user_status_enum.dart';
// import 'package:attendance/models/user_data_singleton.dart';
// import 'package:attendance/screens/individual_check_in_check_out.dart';
//
//
// class AttendanceScreen extends StatelessWidget {
//   final AttendanceController _attendanceController =
//       Get.put(AttendanceController());
//   final AuthController _authController = Get.find();
//   final UserDataSingleton _userData = UserDataSingleton();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Attendance'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.schedule),
//             onPressed: () {
//               Get.toNamed('/shift-details');
//             },
//             tooltip: 'Test Shift Details',
//           ),
//           IconButton(
//             icon: const Icon(Icons.logout),
//             onPressed: () async {
//               await _authController.logout();
//             },
//           ),
//         ],
//       ),
//       body: IndividualCheckInCheckOut(),
//     );
//   }
//
//   Widget _buildUserInfoCard() {
//     return Card(
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Welcome, ${_userData.displayName}',
//               style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),
//             Text(_attendanceController.currentDate),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildActionButtons() {
//     return Obx(() {
//       final canCheckIn = _attendanceController.canCheckIn();
//       final canCheckOut = _attendanceController.canCheckOut();
//       final canTakeBreak = _attendanceController.canTakeBreak();
//
//       return Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               Builder(builder: (context) {
//                 final shiftInfo = Get.find<ShiftDetailsController>().getShiftInfo();
//                 final now = DateTime.now();
//                 final startTimeStr = shiftInfo['startTime'];
//                 final endTimeStr = shiftInfo['endTime'];
//                 DateTime? localStart;
//                 DateTime? localEnd;
//                 DateTime? graceEnd;
//                 bool canCheckInFinal = false;
//
//                 if (startTimeStr != null && endTimeStr != null) {
//                   final partsStart = startTimeStr.split(':');
//                   final partsEnd = endTimeStr.split(':');
//                   int hourStart = int.parse(partsStart[0]);
//                   int minuteStart = int.parse(partsStart[1]);
//                   int secondStart = partsStart.length > 2 ? int.parse(partsStart[2]) : 0;
//                   int hourEnd = int.parse(partsEnd[0]);
//                   int minuteEnd = int.parse(partsEnd[1]);
//                   int secondEnd = partsEnd.length > 2 ? int.parse(partsEnd[2]) : 0;
//
//                   // Parse as UTC, then convert to local
//                   localStart = DateTime.utc(now.year, now.month, now.day, hourStart, minuteStart, secondStart).toLocal();
//                   localEnd = DateTime.utc(now.year, now.month, now.day, hourEnd, minuteEnd, secondEnd).toLocal();
//                   graceEnd = localEnd.add(const Duration(minutes: 15));
//
//                   // Handle overnight shifts (end before start)
//                   if (localEnd.isBefore(localStart)) {
//                     // If now is before start, treat as next day
//                     if (now.isBefore(localStart)) {
//                       localStart = localStart.subtract(const Duration(days: 1));
//                     }
//                     localEnd = localEnd.add(const Duration(days: 1));
//                     graceEnd = localEnd.add(const Duration(minutes: 15));
//                   }
//
//                   canCheckInFinal = now.isAfter(localStart) && now.isBefore(graceEnd);
//                 }
//
//                 print('DEBUG: now=$now, localStart=$localStart, localEnd=$localEnd, graceEnd=$graceEnd');
//                 print('DEBUG: canCheckInFinal=$canCheckInFinal, isLoading=$isLoading');
//
//                 return _buildButton(
//                   context,
//                   icon: Icons.login,
//                   label: 'Check In',
//                   onPressed: canCheckInFinal && !isLoading
//                       ? () async {
//                           final confirmed = await showConfirmationDialog(context, 'check in');
//                           if (confirmed) {
//                             _attendanceController.updateUserStatus(newStatus: UserStatus.Online);
//                           }
//                         }
//                       : null,
//                   color: const Color(0xFF4CAF50),
//                 );
//               }),
//               ElevatedButton(
//                 onPressed: canCheckOut
//                     ? () => _attendanceController.updateUserStatus(
//                         newStatus: UserStatus.Offline)
//                     : null,
//                 child: const Text('Check-Out'),
//               ),
//             ],
//           ),
//           const SizedBox(height: 10),
//           ElevatedButton(
//             onPressed: canTakeBreak
//                 ? () => _attendanceController.updateUserStatus(
//                     newStatus: UserStatus.Break)
//                 : null,
//             child: const Text('Take Break'),
//           ),
//         ],
//       );
//     });
//   }
//
//   Widget _buildStatusInfo() {
//     return Obx(() {
//       final status = _attendanceController.currentUserStatus.value;
//       return Card(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text('Status: \\${status?.name ?? "Unknown"}',
//                   style: const TextStyle(
//                       fontSize: 16, fontWeight: FontWeight.bold)),
//             ],
//           ),
//         ),
//       );
//     });
//   }
//
//   Widget _buildAttendanceLog() {
//     return Obx(() {
//       if (_attendanceController.attendanceLog.isEmpty) {
//         return const Center(child: Text('No attendance log for today.'));
//       }
//       return ListView.builder(
//         itemCount: _attendanceController.attendanceLog.length,
//         itemBuilder: (context, index) {
//           final log = _attendanceController.attendanceLog[index];
//           final timestamp = DateTime.parse(log.timestamp).toLocal();
//           return ListTile(
//             leading: Icon(Icons.history),
//             title: Text(log.status ?? 'Unknown'),
//             subtitle: Text(
//                 '${timestamp.hour}:${timestamp.minute}:${timestamp.second}'),
//           );
//         },
//       );
//     });
//   }
//
//   Widget _buildButton(BuildContext context, {required IconData icon, required String label, required VoidCallback? onPressed, required Color color}) {
//     return ElevatedButton(
//       onPressed: onPressed,
//       style: ElevatedButton.styleFrom(
//         primary: color,
//         onPrimary: Colors.white,
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(30),
//         ),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(icon, size: 24, color: Colors.white),
//           const SizedBox(width: 10),
//           Text(
//             label,
//             style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Future<bool> showConfirmationDialog(BuildContext context, String action) async {
//     return showDialog<bool>(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('Confirm $action'),
//           content: Text('Are you sure you want to $action?'),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(false),
//               child: const Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(true),
//               child: const Text('Confirm'),
//             ),
//           ],
//         );
//       },
//     ) ?? false;
//   }
// }