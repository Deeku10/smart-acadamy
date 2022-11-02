// ignore_for_file: implementation_imports, unnecessary_import

import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:smart_acadamy/heightWidth.dart';
import 'package:smart_acadamy/widgets/loadingWidget.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);
  static const id = '/Loading';

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    var h = context.height;
    return LoadingWidget(
      h: h,
      assetImage: "assets/images/loading.png",
      descriptionText: "Loading...",
    );
  }
}
