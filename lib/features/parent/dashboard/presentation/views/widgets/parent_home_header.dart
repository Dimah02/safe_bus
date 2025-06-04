import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safe_bus/core/styles/colors.dart';
import 'package:safe_bus/core/styles/sizes.dart';
import 'package:safe_bus/features/shared/login/presentation/manager/cubit/auth_cubit.dart';

class ParentHomeHeader extends StatelessWidget {
  const ParentHomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Good Morning,',
              style: TextStyle(
                fontSize: 16,
                color: KColors.darkGrey,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              BlocProvider.of<AuthCubit>(context).user.name ?? " ",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
        Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: KColors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(KSizes.buttonRadius),
            ),
            boxShadow: [
              BoxShadow(
                color: KColors.lighterGrey,
                blurRadius: 10,
                spreadRadius: 0.5,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: IconButton(
            icon: Icon(Icons.notifications),
            iconSize: KSizes.iconMd,
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}
