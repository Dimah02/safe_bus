import 'package:flutter/material.dart';
import 'package:safe_bus/core/styles/colors.dart';
import 'package:safe_bus/core/styles/sizes.dart';

class ChildrenList extends StatefulWidget {
  const ChildrenList({super.key});

  @override
  State<ChildrenList> createState() => _ChildrenListState();
}

class _ChildrenListState extends State<ChildrenList> {
  final List<String> children = ["Adam", "Lina"];
  String selectedChild = "Adam";

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 152,
      padding: EdgeInsets.all(KSizes.lg),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: children.length,
        itemBuilder:(context, index) {
        final currentChild = children[index];
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: ChoiceChip(
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
    );
  }
}