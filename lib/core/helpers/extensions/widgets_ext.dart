import 'dart:io';

import 'package:flutter/widgets.dart';

extension WidgetsExt on Widget {
  Widget withSafeArea() {
    return this;
    return SafeArea(
      top: Platform.isIOS,
      bottom: false,
      right: false,
      left: false,
      child: this,
    );
  }
}
