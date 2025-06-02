import 'package:safe_bus/core/utils/http_client.dart';
import 'package:safe_bus/features/parent/data/models/parents.dart';
import 'package:safe_bus/features/parent/data/models/students.dart';

import 'package:safe_bus/features/shared/login/data/repo/login_repo.dart';

class ParentRepository {
  static final ParentRepository instance = ParentRepository._();
  ParentRepository._();
  
  Future<Parents> getParent() async {
    final userId = await LoginRepo.instance.getID();
    
    final parentJson = await KHTTP.instance.get(endpoint: 'parents/$userId');
      Parents parent = Parents.fromJson(parentJson);
      
    final studentsJson = await KHTTP.instance.get(endpoint: 'students');
      List<Students> allStudents = (studentsJson as List)
      .map((s) => Students.fromJson(s))
      .toList();
    List<Students> children = allStudents
      .where((s) => s.parentId == parent.userId)
      .toList();

    parent.students = children;

    return parent;
  }
}