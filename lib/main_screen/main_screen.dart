import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:provider/provider.dart';

import '../local_notification_service.dart';
import 'widgets/widgets.dart';
import '../screens/screens.dart';
import '../providers/providers.dart';
import '../utils/utils.dart';

class MainScreen extends StatefulWidget {
  final String whatsAppContact;
  const MainScreen({Key? key, required this.whatsAppContact}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.detached) {
      if (Platform.isAndroid) {
        Provider.of<PlayerStateProvider>(context, listen: false).hardStop();
        Provider.of<PlayerStateProvider>(context, listen: false).dispose();
      }
    }
    if (state == AppLifecycleState.resumed &&
        !Provider.of<PlayerStateProvider>(context, listen: false).isPlaying) {
      Provider.of<PlayerStateProvider>(context, listen: false).play();
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
    Future.delayed(Duration.zero, () async {
      //to run async code in initState
      await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
      //enables secure mode for app, disables screenshot, screen recording
    });
    Provider.of<ConnectivityProvider>(context, listen: false)
        .initialConnectionCheck(context);
    Provider.of<ConnectivityProvider>(context, listen: false)
        .initConnectionSubstription(context);
    Provider.of<PlayerStateProvider>(context, listen: false).initPlayer();
    Provider.of<PlayerStateProvider>(context, listen: false)
        .playerStreamListener();
    FirebaseMessaging.instance.getToken().then((String? token) {
      assert(token != null);
    });

    FirebaseMessaging.onMessage.listen(
      (message) {
        print("front");
        LocalNotificationService.display(message);
      },
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    Provider.of<PlayerStateProvider>(context, listen: false).dispose();
    Provider.of<ConnectivityProvider>(context, listen: false)
        .disposeConnectionSubstription();
    super.dispose();
  }

  void playOrStop() {
    if (Provider.of<PlayerStateProvider>(context, listen: false).isPlaying) {
      Provider.of<PlayerStateProvider>(context, listen: false).hardStop();
    } else {
      Provider.of<PlayerStateProvider>(context, listen: false).play();
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      Home(playOrStop: playOrStop, whatsAppContact: widget.whatsAppContact),
      Provider.of<NavTabProvider>(context, listen: false)
              .loadedPages
              .contains(1)
          ? const Contest()
          : Container(),
      Provider.of<NavTabProvider>(context, listen: false)
              .loadedPages
              .contains(2)
          ? const Schedule()
          : Container(),
      Provider.of<NavTabProvider>(context, listen: false)
              .loadedPages
              .contains(3)
          ? const Contact()
          : Container(),
    ];

    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          gradient: bgGradient,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Scaffold(
          backgroundColor: bScaffoldL,
          bottomNavigationBar: const BottomBar(),
          body: IndexedStack(
            children: screens,
            index: Provider.of<NavTabProvider>(context).tabIndex,
          ),
        ),
      ),
    );
  }
}
