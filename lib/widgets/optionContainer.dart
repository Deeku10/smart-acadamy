// ignore_for_file: file_names, no_logic_in_create_state, unnecessary_this, sort_child_properties_last

import 'package:flutter/material.dart';

class OptionContainer extends StatefulWidget {
  const OptionContainer({
    Key? key,
    required this.h,
    required this.w,
    required this.answer,
    required this.tapped,
  }) : super(key: key);

  final double h;
  final double w;
  final String answer;
  final bool tapped;

  @override
  State<OptionContainer> createState() => _OptionContainerState(this.tapped);
}

class _OptionContainerState extends State<OptionContainer> {
  final bool tapped;

  _OptionContainerState(this.tapped);
  bool tap = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          tap = !tap;
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(
            vertical: widget.h * 0.01, horizontal: widget.w * 0.03),
        padding: EdgeInsets.symmetric(
            vertical: widget.h * 0.021, horizontal: widget.w * 0.04),
        height: widget.h * 0.07,
        width: widget.w * 0.9,
        child: FittedBox(
          fit: BoxFit.contain,
          alignment: Alignment.centerLeft,
          child: Text(
            widget.answer,
            style: TextStyle(
                color: Colors.black,
                fontSize: widget.h * 0.025,
                fontWeight: FontWeight.bold),
          ),
        ),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: tap ? Colors.green : const Color(0xfff5f5f5)),
      ),
    );
  }
}
