import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;

  const Responsive({super.key, required this.mobile, required this.tablet});

  static bool isMobile(BuildContext context) => MediaQuery.of(context).size.width < 768;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 768 && MediaQuery.of(context).size.width < 1024;

  @override
  Widget build(BuildContext context) {
    if (isTablet(context)) {
      return tablet;
    } else {
      return mobile;
    }
  }
}
