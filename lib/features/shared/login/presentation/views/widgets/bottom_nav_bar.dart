import 'package:flutter/material.dart';
import 'package:safe_bus/core/styles/colors.dart';
import 'package:safe_bus/core/styles/sizes.dart';

class BottomNavBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;
  final int userType;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.userType,
  });

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: KColors.white,
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: KColors.lighterGrey,
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: SizedBox(
        height: 40,
        width: 150,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _NavBarIcon(
              icon: Icons.home,
              index: 0,
              currentIndex: widget.currentIndex,
              onTap: () {
                widget.onTap(0);
                setState(() {});
              },
            ),
            SizedBox(width: KSizes.spaceBtwItems),
            _NavBarIcon(
              icon: Icons.person,
              index: 1,
              currentIndex: widget.currentIndex,
              onTap: () {
                widget.onTap(1);
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _NavBarIcon extends StatelessWidget {
  final IconData icon;
  final int index;
  final int currentIndex;
  final VoidCallback onTap;

  const _NavBarIcon({
    required this.icon,
    required this.index,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = currentIndex == index;
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.shade100 : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: isSelected ? Colors.blue : Colors.grey,
          size: 26,
        ),
      ),
    );
  }
}
