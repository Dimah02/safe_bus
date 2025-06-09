import 'package:flutter/material.dart';

class ProfileOption extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color iconColor;
  final Widget? trailing;
  final VoidCallback? onTap;

  const ProfileOption({
    super.key,
    required this.icon,
    required this.text,
    required this.iconColor,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(text),
      trailing: trailing,
      contentPadding: EdgeInsets.all(5),
      onTap: onTap,
    );
  }
}