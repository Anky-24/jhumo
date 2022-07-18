import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:jhumo/providers/player_state_provider.dart';
import 'package:jhumo/utils/utils.dart';

class PlayOrStop extends StatelessWidget {
  final void Function() playOrStop;
  const PlayOrStop({Key? key, required this.playOrStop}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      height: MediaQuery.of(context).size.height * 0.125,
      decoration: const BoxDecoration(
        color: Colors.transparent,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 0),
            color: Colors.black12,
            blurRadius: 5.0,
            spreadRadius: 0.0,
          ),
        ],
        shape: BoxShape.circle,
      ),
      child: Provider.of<PlayerStateProvider>(context).isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: loaderL,
              ),
            )
          : GestureDetector(
              onTap: playOrStop,
              child: Center(
                child: Image.asset(
                  Provider.of<PlayerStateProvider>(context).isPlaying
                      ? stopBtn
                      : playBtn,
                  fit: BoxFit.contain,
                ),
              ),
            ),
    );
  }
}
