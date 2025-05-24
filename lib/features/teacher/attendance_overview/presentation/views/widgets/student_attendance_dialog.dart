import 'package:flutter/material.dart';

class StudentAttendanceDialog extends StatelessWidget {
  final String studentName;
  final String timeRecorded;
  final String location;
  final String recordedBy;
  final String remarks;
  final String currentStatus;
  final Function(bool isPresent) onStatusChanged;

  const StudentAttendanceDialog({
    super.key,
    required this.studentName,
    required this.timeRecorded,
    required this.location,
    required this.recordedBy,
    required this.remarks,
    required this.currentStatus,
    required this.onStatusChanged,
  });

  static void show({
    required BuildContext context,
    required String studentName,
    required String timeRecorded,
    required String location,
    required String recordedBy,
    required String remarks,
    required String currentStatus,
    required Function(bool isPresent) onStatusChanged,
  }) {
    showDialog(
      context: context,
      builder:
          (context) => StudentAttendanceDialog(
            studentName: studentName,
            timeRecorded: timeRecorded,
            location: location,
            recordedBy: recordedBy,
            remarks: remarks,
            currentStatus: currentStatus,
            onStatusChanged: onStatusChanged,
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: _buildDialogContent(context),
    );
  }

  Widget _buildDialogContent(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            offset: Offset(0.0, 10.0),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 24, bottom: 12),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.grey[200],
                  child: Icon(Icons.person, size: 40, color: Colors.grey[400]),
                ),
                const SizedBox(height: 12),
                Text(
                  'Student: $studentName',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 8.0,
            ),
            child: Column(
              children: [
                _buildDetailRow('Time of Absence Recorded:', timeRecorded),
                const SizedBox(height: 8),
                _buildDetailRow('Location:', location),
                const SizedBox(height: 8),
                _buildDetailRow('Recorded By:', recordedBy),
                const SizedBox(height: 8),
                _buildDetailRow('Remarks:', remarks),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      onStatusChanged(false);
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                        side: const BorderSide(color: Colors.red),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text('Absent', style: TextStyle(fontSize: 16)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      onStatusChanged(true);
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text(
                      'Present',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
