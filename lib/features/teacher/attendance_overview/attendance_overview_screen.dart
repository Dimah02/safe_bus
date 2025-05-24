import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:safe_bus/features/teacher/attendance_overview/student_attendance_dialog.dart';

class AttendanceOverviewScreen extends StatefulWidget {
  const AttendanceOverviewScreen({super.key});

  @override
  State<AttendanceOverviewScreen> createState() =>
      _AttendanceOverviewScreenState();
}

class _AttendanceOverviewScreenState extends State<AttendanceOverviewScreen> {
  final totalStudents = 30;
  final totalPresent = 15;
  final totalAbsent = 15;
  final notMarked = 3;
  final markedIndividually = 20;

  late List<Map<String, dynamic>> studentAttendance;

  @override
  void initState() {
    super.initState();
    studentAttendance = [
      {
        'name': 'Nadia Al-Shareef',
        'status': 'A',
        'statusColor': Colors.red,
        'timeRecorded': '7:45 AM',
        'location': 'Bus Stop - Zone 3',
        'recordedBy': 'Shahad Ahmad',
        'remarks': '"Parent informed of absence."',
        'avatar': 'images/placeholders/student-avatar-1.svg',
      },
      {
        'name': 'Faisal Al-Fahad',
        'status': 'A',
        'statusColor': Colors.red,
        'timeRecorded': '7:50 AM',
        'location': 'Main Entrance',
        'recordedBy': 'Mohammad Khalid',
        'remarks': '"No notification received."',
        'avatar': 'images/placeholders/student-avatar-2.svg',
      },
      {
        'name': 'Salah Al-Ghanim',
        'status': 'P',
        'statusColor': Colors.green,
        'timeRecorded': '7:20 AM',
        'location': 'Classroom 203',
        'recordedBy': 'Fatima Ahmed',
        'remarks': '"Arrived early."',
        'avatar': 'images/placeholders/student-avatar-3.svg',
      },
      {
        'name': 'Nawaf Baroum',
        'status': 'A',
        'statusColor': Colors.red,
        'timeRecorded': '7:55 AM',
        'location': 'School Gate',
        'recordedBy': 'Hassan Ali',
        'remarks': '"Medical leave."',
        'avatar': 'images/placeholders/student-avatar-4.svg',
      },
      {
        'name': 'Maha Qahtani',
        'status': 'P',
        'statusColor': Colors.green,
        'timeRecorded': '7:25 AM',
        'location': 'Library',
        'recordedBy': 'Layla Mahmoud',
        'remarks': '"Attending morning study group."',
        'avatar': 'images/placeholders/student-avatar-5.svg',
      },
      {
        'name': 'Munifah Salsalah',
        'status': 'P',
        'statusColor': Colors.green,
        'timeRecorded': '7:30 AM',
        'location': 'Sports Hall',
        'recordedBy': 'Omar Khaled',
        'remarks': '"Present for morning practice."',
        'avatar': 'images/placeholders/student-avatar-6.svg',
      },
    ];
  }

  void _updateStudentStatus(int index, bool isPresent) {
    setState(() {
      studentAttendance[index]['status'] = isPresent ? 'P' : 'A';
      studentAttendance[index]['statusColor'] =
          isPresent ? Colors.green : Colors.red;
    });
  }

  void _showStudentAttendanceDialog(BuildContext context, int index) {
    final student = studentAttendance[index];

    StudentAttendanceDialog.show(
      context: context,
      studentName: student['name'],
      timeRecorded: student['timeRecorded'],
      location: student['location'],
      recordedBy: student['recordedBy'],
      remarks: student['remarks'],
      currentStatus: student['status'],
      onStatusChanged: (isPresent) {
        _updateStudentStatus(index, isPresent);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance Overview'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Text(
              'Tuesday, 7:30-8:30',
              style: TextStyle(color: Colors.grey[600], fontSize: 16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard(
                        'Total Students',
                        '$totalStudents',
                        Colors.blue.shade200,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildStatCard(
                        'Total Present',
                        '$totalPresent',
                        Colors.green.shade200,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard(
                        'Total Absent',
                        '$totalAbsent',
                        Colors.red.shade200,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildStatCard(
                        'Not Marked',
                        '$notMarked',
                        Colors.grey.shade200,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Mark Individually $markedIndividually',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey.shade200,
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: studentAttendance.length,
              itemBuilder: (context, index) {
                final student = studentAttendance[index];
                return InkWell(
                  onTap: () => _showStudentAttendanceDialog(context, index),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.grey[200],
                      child:
                          student['avatar'] != null
                              ? SvgPicture.asset(
                                student['avatar'],
                                width: 40,
                                height: 40,
                              )
                              : Icon(Icons.person, color: Colors.grey[400]),
                    ),
                    title: Text(student['name'] as String),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildAttendanceButton(
                          'P',
                          student['status'] == 'P'
                              ? Colors.green
                              : Colors.grey.shade300,
                          student['status'] == 'P' ? Colors.white : Colors.grey,
                          () => _updateStudentStatus(index, true),
                        ),
                        const SizedBox(width: 8),
                        _buildAttendanceButton(
                          'A',
                          student['status'] == 'A'
                              ? Colors.red
                              : Colors.grey.shade300,
                          student['status'] == 'A' ? Colors.white : Colors.grey,
                          () => _updateStudentStatus(index, false),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String count, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
          const SizedBox(height: 4),
          Text(
            count,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAttendanceButton(
    String text,
    Color backgroundColor,
    Color textColor,
    VoidCallback onPressed,
  ) {
    return InkWell(
      onTap: onPressed,
      child: CircleAvatar(
        radius: 15,
        backgroundColor: backgroundColor,
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
