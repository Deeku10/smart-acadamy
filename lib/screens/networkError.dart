// ignore_for_file: implementation_imports, unnecessary_import, file_names
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_acadamy/heightWidth.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:smart_acadamy/screens/loading.dart';
import 'package:smart_acadamy/widgets/loadingWidget.dart';
import 'package:provider/provider.dart';

class NetworkError extends StatefulWidget {
  const NetworkError({Key? key}) : super(key: key);
  static const id = '/NetworkError';
  @override
  State<NetworkError> createState() => _NetworkErrorState();
}

class _NetworkErrorState extends State<NetworkError> {
  @override
  Widget build(BuildContext context) {
    var h = context.height;

    return LoadingWidget(
      h: h,
      assetImage: "assets/images/NoInternetConnection.png",
      descriptionText: "No Network\nTake a long breath",
    );
  }
}

class ConnectivityProvider with ChangeNotifier {
  Connectivity _connetivity = Connectivity();
  bool _isOnline = false;
  bool get isOnline => _isOnline;
  startMonitoring() async {
    await initConnectivity();
    _connetivity.onConnectivityChanged.listen((result) async {
      if (result == ConnectivityResult.none) {
        _isOnline = false;
        notifyListeners();
      } else {
        await _updateConnectionStatus().then((bool isConnected) {
          _isOnline = isConnected;
          notifyListeners();
        });
      }
    });
  }

  Future<void> initConnectivity() async {
    try {
      var status = await _connetivity.checkConnectivity();
      if (status == ConnectivityResult.none) {
        _isOnline = false;
        notifyListeners();
      } else {
        _isOnline = true;
        notifyListeners();
      }
    } on PlatformException catch (e) {
      print("platexception" + e.toString());
    }
  }

  Future<bool> _updateConnectionStatus() async {
    bool isConnected;
    try {
      final List<InternetAddress> result =
          await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isConnected = true;
      } else {
        isConnected = false;
      }
    } on SocketException catch (_) {
      isConnected = false;
    }
    return isConnected;
  }
}

Widget pageUI(Widget widget) {
  return Consumer<ConnectivityProvider>(builder: (context, model, child) {
    if (model.isOnline != null) {
      return model.isOnline ? widget : NetworkError();
    }
    return Loading();
  });
}
