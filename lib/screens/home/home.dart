// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:jhumo/utils/constants/constants.dart';

import 'widgets/widgets.dart';

import 'home_services.dart';

class Home extends StatelessWidget {
  final void Function() playOrStop;
  const Home({Key? key, required this.playOrStop}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            ActionCenter(
              icon: Icons.info_outline_rounded,
              color: Colors.transparent,
              onTap: () => showDialog(
                context: context,
                builder: (_) => const AlertDialog(
                    title: Text(
                      "About Us",
                      style: TextStyle(fontSize: 22),
                      textAlign: TextAlign.center,
                    ),
                    content: SingleChildScrollView(
                      child: Text(
                        about,
                        style: TextStyle(fontSize: 18),
                        textAlign: TextAlign.justify,
                      ),
                    )),
              ),
            ),
            const Spacer(
              flex: 1,
            ),
            ActionCenter(
              icon: Icons.share,
              color: Colors.transparent,
              onTap: () {
                share(context);
              },
            ),
            const SizedBox(
              width: 10,
            ),
            ActionCenter(
              icon: Icons.whatsapp_rounded,
              color: Colors.transparent,
              onTap: () => launchWhatsapp("919672020169"),
            ),
          ],
        ),
        const Spacer(),
        const LogoRecord(),
        const Spacer(),
        Row(
          children: [
            const Expanded(
              // child: Provider.of<PlayerStateProvider>(context).isPlaying
              //     ? CachedNetworkImage(
              //         imageUrl:
              //             "https://firebasestorage.googleapis.com/v0/b/jhumo-radio.appspot.com/o/dance_animation.gif?alt=media")
              //     : const Text(""),
              child: Text(""),
            ),
            PlayOrStop(
              playOrStop: playOrStop,
            ),
            const Expanded(
              // child: Provider.of<PlayerStateProvider>(context).isPlaying
              //     ? CachedNetworkImage(
              //         imageUrl:
              //             "https://firebasestorage.googleapis.com/v0/b/jhumo-radio.appspot.com/o/dance_animation.gif?alt=media")
              //     : const Text(""),
              child: Text(""),
            ),
          ],
        ),
        const Spacer(),

        // Text(
        //   currentShow,
        //   textAlign: TextAlign.center,
        //   style: Theme.of(context).textTheme.bodyText1?.copyWith(
        //         fontWeight: FontWeight.w700,
        //         color: const Color(0xffffffff),
        //       ),
        // ),
        // const Spacer(
        //   flex: 2,
        // ),
      ],
    );
  }
}
