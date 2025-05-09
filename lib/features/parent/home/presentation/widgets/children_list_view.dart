import 'package:flutter/material.dart';
import 'package:safe_bus/core/styles/colors.dart';
import 'package:safe_bus/core/styles/sizes.dart';

class ChildrenList extends StatefulWidget {
  const ChildrenList({super.key});

  @override
  State<ChildrenList> createState() => _ChildrenListState();
}

class _ChildrenListState extends State<ChildrenList> {
  final List<String> children = ["Adam", "Lina", "Hamza"];
  String selectedChild = "Adam";

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,

      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: children.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Padding(
              padding: EdgeInsets.only(top: 8, bottom: 8, right: 16),
              child: Text(
                "Children",
                style: TextStyle(
                  color: KColors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: KSizes.fonstSizeLg,
                ),
              ),
            );
          }
          index--;
          final currentChild = children[index];
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedChild = currentChild;
              });
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 5),
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color:
                    selectedChild == currentChild
                        ? KColors.greenPrimary
                        : KColors.greenAccent,
              ),
              child: Text(
                currentChild,
                style: TextStyle(
                  color: KColors.white,
                  fontSize: KSizes.fontSizeMd,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
