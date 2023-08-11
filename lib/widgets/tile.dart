import 'package:flutter/material.dart';

class Tile extends StatelessWidget {
  final Widget child;
  final Color color;
  const Tile({Key? key, required this.child,required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(6.0),
      child: Material(
        borderRadius: BorderRadius.circular(12.0),
        color: color,
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: child,
        ),
      ),
    );
  }
}
