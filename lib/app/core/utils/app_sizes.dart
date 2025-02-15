import 'package:flutter/widgets.dart';

class AppSizes {
  static double paddingSmall(BuildContext context) => MediaQuery.of(context).size.width * 0.03;
  static double paddingMedium(BuildContext context) => MediaQuery.of(context).size.width * 0.05;
  static double paddingLarge(BuildContext context) => MediaQuery.of(context).size.width * 0.08;
}
