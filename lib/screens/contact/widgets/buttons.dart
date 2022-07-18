import 'package:flutter/material.dart';

class IcnBtn extends StatelessWidget {
  final IconData icon;
  final String label;
  final void Function() onTap;
  const IcnBtn(
      {Key? key, required this.icon, required this.label, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.resolveWith(
          (states) => Colors.white,
        ),
        elevation: MaterialStateProperty.resolveWith((states) => 1.0),
        backgroundColor: MaterialStateProperty.resolveWith(
          (states) => Colors.black12,
        ),
        padding: MaterialStateProperty.resolveWith(
          (states) => const EdgeInsets.all(16),
        ),
        textStyle: MaterialStateProperty.resolveWith(
          (states) => Theme.of(context).textTheme.bodyText1!.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                overflow: TextOverflow.ellipsis,
              ),
        ),
      ),
      onPressed: onTap,
      icon: Icon(icon),
      label: Text(label),
    );
  }
}
