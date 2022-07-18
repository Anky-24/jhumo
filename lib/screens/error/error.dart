import "package:flutter/material.dart";

import '../../utils/utils.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: bgGradient,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: Text(
              "An Unexpected error occured, Try restarting the app or check your network connection.",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
