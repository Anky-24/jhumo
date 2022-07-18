import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:jhumo/utils/utils.dart';
import 'package:jhumo/providers/providers.dart';

class LogoRecord extends StatefulWidget {
  const LogoRecord({
    Key? key,
  }) : super(key: key);

  @override
  State<LogoRecord> createState() => _LogoRecordState();
}

class _LogoRecordState extends State<LogoRecord>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  double target = 0.0;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 10000),
      vsync: this,
    );
    _controller.repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (Provider.of<PlayerStateProvider>(context).isPlaying) {
      _controller.repeat();
    } else {
      _controller.animateTo(0.0, duration: const Duration(milliseconds: 300));
    }
    return RotationTransition(
      turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
      child: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              spreadRadius: 2.0,
            ),
            BoxShadow(
              color: primaryL,
              offset: Offset(0.0, 0.0),
              blurRadius: 0.0,
              spreadRadius: 0.0,
            ),
          ],
        ),
        height: MediaQuery.of(context).size.height * 0.4,
        child: Image.asset(
          transparentLogo,
          fit: BoxFit.contain,
          width: MediaQuery.of(context).size.width * 0.9,
        ),
      ),
    );
  }
}
