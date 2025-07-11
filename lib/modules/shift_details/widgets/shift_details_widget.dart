import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/shift_details_controller.dart';
import '../models/check_in_validation.dart';

class ShiftDetailsWidget extends StatelessWidget {
  const ShiftDetailsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get the controller instance
    final controller = Get.find<ShiftDetailsController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shift Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => controller.refresh(),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (controller.hasError.value) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 64,
                  color: Colors.red[300],
                ),
                const SizedBox(height: 16),
                Text(
                  'Error Loading Shift Details',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                Text(
                  controller.errorMessage.value,
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => controller.refresh(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        if (!controller.hasShiftData) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.schedule,
                  size: 64,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 16),
                Text(
                  'No Shift Data Available',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                Text(
                  'Shift details will be loaded automatically',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          );
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildShiftInfoCard(controller),
              const SizedBox(height: 16),
              _buildWorkingHoursCard(controller),
              const SizedBox(height: 16),
              _buildValidationCard(controller),
              const SizedBox(height: 16),
              _buildActionsCard(controller),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildShiftInfoCard(ShiftDetailsController controller) {
    final shiftInfo = controller.getShiftInfo();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  shiftInfo['hasData'] ? Icons.work : Icons.schedule,
                  color: shiftInfo['hasData'] ? Colors.green : Colors.grey,
                ),
                const SizedBox(width: 8),
                Text(
                  'Shift Information',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (shiftInfo['hasData']) ...[
              _buildInfoRow('Type', shiftInfo['type']),
              _buildInfoRow('Name', shiftInfo['name']),
              if (shiftInfo['type'] == 'shift') ...[
                _buildInfoRow('Start Time', shiftInfo['startTime']),
                _buildInfoRow('End Time', shiftInfo['endTime']),
                _buildInfoRow('Buffer Time', '${shiftInfo['bufferTime']} ms'),
                _buildInfoRow('Allowed Break', '${shiftInfo['allowedBreak']} ms'),
                if (shiftInfo['description']?.isNotEmpty == true)
                  _buildInfoRow('Description', shiftInfo['description']),
              ] else ...[
                _buildInfoRow('Buffer Time', '${shiftInfo['bufferTime']} ms'),
                _buildInfoRow('Allowed Break', '${shiftInfo['allowedBreak']} ms'),
              ],
            ] else ...[
              Text(
                shiftInfo['message'],
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildWorkingHoursCard(ShiftDetailsController controller) {
    final workingHours = controller.getCurrentDayWorkingHours();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  workingHours['hasData'] ? Icons.access_time : Icons.schedule,
                  color: workingHours['hasData'] ? Colors.blue : Colors.grey,
                ),
                const SizedBox(width: 8),
                Text(
                  'Today\'s Working Hours',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (workingHours['hasData']) ...[
              _buildInfoRow('Type', workingHours['type']),
              if (workingHours['type'] == 'regular') ...[
                _buildInfoRow('Start Time', workingHours['startTime']),
                _buildInfoRow('End Time', workingHours['endTime']),
              ] else ...[
                _buildInfoRow('Status', workingHours['message']),
              ],
            ] else ...[
              Text(
                workingHours['message'],
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildValidationCard(ShiftDetailsController controller) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.check_circle,
                  color: Colors.orange,
                ),
                const SizedBox(width: 8),
                Text(
                  'Validation Status',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Obx(() {
              final validation = controller.lastValidation.value;
              if (validation == null) {
                return Text(
                  'No validation performed yet',
                  style: const TextStyle(color: Colors.grey),
                );
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildValidationRow('Valid Time', validation.isValidTime),
                  _buildValidationRow('24 Hours', validation.is24Hrs),
                  _buildValidationRow('Completed', validation.isCompeletedAttendance),
                  if (validation.expectedStartTime != null)
                    _buildInfoRow('Expected Start', 
                        DateTime.fromMillisecondsSinceEpoch(validation.expectedStartTime!).toString()),
                  if (validation.expectedEndTime != null)
                    _buildInfoRow('Expected End', 
                        DateTime.fromMillisecondsSinceEpoch(validation.expectedEndTime!).toString()),
                  if (validation.inRestrictedUser?.isNotEmpty == true)
                    _buildInfoRow('Restricted Users', validation.inRestrictedUser!.join(', ')),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildActionsCard(ShiftDetailsController controller) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.play_arrow,
                  color: Colors.green,
                ),
                const SizedBox(width: 8),
                Text(
                  'Actions',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Example: Validate check-in for individual user
                      final validation = controller.validateIndividualCheckIn(
                        lastCheckOutTime: DateTime.now().millisecondsSinceEpoch - 3600000, // 1 hour ago
                      );
                      
                      Get.snackbar(
                        'Validation Result',
                        controller.getValidationSummary(),
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    },
                    child: const Text('Test Individual Validation'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => controller.refresh(),
                    child: const Text('Refresh'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => controller.clearCache(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                    ),
                    child: const Text('Clear Cache'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => controller.clearShiftDetails(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: const Text('Clear Data'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildValidationRow(String label, bool value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ),
          Icon(
            value ? Icons.check_circle : Icons.cancel,
            color: value ? Colors.green : Colors.red,
            size: 20,
          ),
          const SizedBox(width: 8),
          Text(
            value ? 'Yes' : 'No',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              color: value ? Colors.green : Colors.red,
            ),
          ),
        ],
      ),
    );
  }
} 