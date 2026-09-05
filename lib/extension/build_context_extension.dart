import 'package:flutter/cupertino.dart';

extension BuildContextExtension on Widget {
  Padding withHorizontalPadding(double value) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: value),
      child: this,
    );
  }

  Padding withVerticalPadding(double value) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(vertical: value),
      child: this,
    );
  }
}
