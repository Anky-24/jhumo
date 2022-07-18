import "package:flutter/material.dart";

import '../../utils/utils.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: bgGradient,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: const Center(
            child: CircularProgressIndicator(
              color: loaderL,
            ),
          ),
        ),
      ),
    );
  }
}
