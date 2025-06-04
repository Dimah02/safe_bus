import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safe_bus/core/styles/colors.dart';
import 'package:safe_bus/core/styles/sizes.dart';
import 'package:safe_bus/features/parent/dashboard/presentation/manager/parent_home_cubit.dart';

class ChildrenList extends StatelessWidget {
  const ChildrenList({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount:
            BlocProvider.of<ParentHomeCubit>(context).students!.length + 1,
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
          final currentChild =
              BlocProvider.of<ParentHomeCubit>(context).students![index];
          return GestureDetector(
            onTap: () {
              BlocProvider.of<ParentHomeCubit>(
                context,
              ).changeIndex(index: index);
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 5),
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color:
                    BlocProvider.of<ParentHomeCubit>(context).index == index
                        ? KColors.greenPrimary
                        : KColors.greenAccent,
              ),
              child: Text(
                currentChild.studentName ?? '',
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
