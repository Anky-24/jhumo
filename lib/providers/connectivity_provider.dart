import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:jhumo/providers/player_state_provider.dart';
import 'package:jhumo/utils/utils.dart';
import 'package:provider/provider.dart';

class ConnectivityProvider extends ChangeNotifier {
  late StreamSubscription subscription;
  late bool _isAlerted;

  Future<void> _internetAlert(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const AlertDialog(
            title: Text(internetAleartHeader),
            content: SingleChildScrollView(
              child: Text(internetAleartBody),
            ));
      },
    );
  }

  void initConnectionSubstription(BuildContext context) {
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        Provider.of<PlayerStateProvider>(context, listen: false).hardStop();
        _internetAlert(context);
        _isAlerted = true;
      } else {
        if (_isAlerted) Navigator.of(context).pop();
        _isAlerted = false;
        Provider.of<PlayerStateProvider>(context, listen: false).play();
      }
    });
  }

  Future<void> initialConnectionCheck(BuildContext context) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Provider.of<PlayerStateProvider>(context, listen: false).hardStop();
      _internetAlert(context);
      _isAlerted = true;
    } else {
      _isAlerted = false;
    }
  }

  void disposeConnectionSubstription() {
    subscription.cancel();
  }
}
