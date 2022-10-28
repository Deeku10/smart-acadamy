import 'package:flutter/material.dart';
import 'package:smart_acadamy/heightWidth.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:smart_acadamy/widgets/loadingWidget.dart';

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
    var w = context.width;
    return LoadingWidget(
      h: h,
      assetImage: "assets/images/NoInternetConnection.png",
      descriptionText: "     No Network\nTake a long breath",
    );
  }
}
