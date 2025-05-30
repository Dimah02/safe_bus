import 'package:flutter/material.dart';
import 'package:safe_bus/core/styles/colors.dart';
import 'package:safe_bus/core/styles/image_strings.dart';
import 'package:safe_bus/core/styles/sizes.dart';
import 'package:safe_bus/features/driver/map/data/models/student_model/student_model.dart';

class ChildrenListView extends StatelessWidget {
  const ChildrenListView({
    super.key,
    required this.controller,
    required this.students,
    required this.header,
  });
  final List<StudentModel> students;
  final ScrollController controller;
  final Widget header;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: KColors.white),
      child: ListView.builder(
        padding: EdgeInsets.all(KSizes.md),
        physics: ClampingScrollPhysics(),
        controller: controller,
        itemCount: students.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return header;
          }
          index--;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 2, horizontal: 6),
                  decoration: BoxDecoration(
                    border: Border.all(color: KColors.grey, width: 2),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Text("${index + 1}", style: TextStyle(fontSize: 8)),
                ),
                SizedBox(width: KSizes.sm),
                CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage(KImage.child),
                ),
                SizedBox(width: KSizes.sm),
                Text(
                  students[index].studentName ?? '',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                Spacer(),
                students[index].rideStatus == 0
                    ? Text("Pending", style: TextStyle(color: KColors.darkGrey))
                    : students[index].rideStatus == 1
                    ? Text(
                      "Present",
                      style: TextStyle(color: KColors.greenSecondary),
                    )
                    : Text("Absent", style: TextStyle(color: KColors.fadedRed)),
                SizedBox(width: KSizes.md),
              ],
            ),
          );
        },
      ),
    );
  }
}
