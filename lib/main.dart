import 'dart:async';
import 'dart:io';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jhumo/main_screen/main_screen.dart';
import 'package:jhumo/screens/screens.dart';
import 'package:jhumo/utils/utils.dart';
import './updated_package/just_audio_background.dart';
import 'package:provider/provider.dart';

import 'local_notification_service.dart';
import 'providers/providers.dart';
import 'firebase_options.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  print("bg called");
  Platform.isAndroid
      ? await Firebase.initializeApp()
      : await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        );
  LocalNotificationService.display(message);
}

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    Platform.isAndroid
        ? await Firebase.initializeApp()
        : await Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform,
          );
    await FirebaseMessaging.instance.subscribeToTopic("all");
    FirebaseMessaging.onBackgroundMessage(backgroundHandler);
    LocalNotificationService.initialize();

    await JustAudioBackground.init(
      androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
      androidNotificationChannelName: 'Audio playback',
      androidNotificationOngoing: true,
      androidStopForegroundOnPause: true,
      androidNotificationIcon: 'mipmap/ic_notification',
    );

    SystemChrome.setPreferredOrientations(
            [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
        .then((_) {
      runApp(const PreApp());
    });
  }, (Object error, StackTrace stack) {
    if (error is! PlatformException) {
      if (Platform.isAndroid) {
        exit(1);
      }
    }
  });
}

class PreApp extends StatelessWidget {
  const PreApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) =>
              PlayerStateProvider(isPlaying: false, isLoading: true),
        ),
        ChangeNotifierProvider(
          create: (context) => NavTabProvider(
            tabIndex: 0,
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => ConnectivityProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Jhumo Radio',
        theme: JhumoTheme.lightTheme,
        builder: (BuildContext context, Widget? widget) {
          ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
            return const ErrorScreen();
          };
          return widget!;
        },
        home: AnimatedSplashScreen(
            curve: Curves.bounceOut,
            splashIconSize: 200,
            duration: 500,
            splash: Image.asset(
              transparentLogo,
              fit: BoxFit.contain,
              width: 300,
            ),
            nextScreen: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              future: FirebaseFirestore.instance
                  .collection("base_info")
                  .doc("home_info")
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const ErrorScreen();
                } else if (snapshot.hasData) {
                  final Map<String, dynamic> homeData =
                      snapshot.data!.data() as Map<String, dynamic>;
                  context
                      .watch<PlayerStateProvider>()
                      .setUrl(homeData['radio_stream_url']);
                  return MainScreen(
                      whatsAppContact: homeData['whatsApp_contact']);
                } else {
                  return const LoadingScreen();
                }
              },
            ),
            splashTransition: SplashTransition.scaleTransition,
            backgroundColor: const Color(0xfffa8a28)),
      ),
    );
  }
}
