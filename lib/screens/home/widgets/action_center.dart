import 'package:flutter/material.dart';

import 'package:jhumo/utils/utils.dart';

class ActionCenter extends StatelessWidget {
  final IconData icon;
  final Color color;
  final void Function() onTap;
  const ActionCenter({
    Key? key,
    required this.icon,
    required this.color,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      highlightColor: bgHomeIconL,
      splashRadius: 30,
      onPressed: onTap,
      icon: Icon(
        icon,
        color: homeIconL,
        size: 30,
      ),
    );
  }
}
