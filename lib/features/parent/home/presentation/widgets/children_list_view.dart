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
    return Container(
      padding: EdgeInsets.fromLTRB(0, KSizes.sm, 0, KSizes.md),
      child: SizedBox(
        height: 40,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: children.length,
          itemBuilder:(context, index) {
          final currentChild = children[index];
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: ChoiceChip(
              backgroundColor: KColors.lightGreen,
              side: BorderSide(
                color: KColors.lightGreen
              ),
              label: Text(currentChild,
                style: TextStyle(
                  color: KColors.black,
                  fontSize: KSizes.fonstSizeSm
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(KSizes.borderRadiusxLg)
              ),
              selected: selectedChild == currentChild,
              onSelected: (selected) {
                setState((){
                  selectedChild = currentChild;
                });
              },
            )
          );
          },
        )
      )
    );
  }
}
