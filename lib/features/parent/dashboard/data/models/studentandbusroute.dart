import 'package:safe_bus/features/parent/dashboard/data/models/parent_home/student_route.dart';

class Studentandbusroute {
  final int studentId;
  final bool isMorning;
  final StudentRoute studnetroute;

  Studentandbusroute({
    required this.studnetroute,
    required this.isMorning,
    required this.studentId,
  });
}
