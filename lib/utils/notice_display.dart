import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../pages/notice.dart';

class NoticeDisplay {
  static display(String url, BuildContext context) {
    DeviceScreenType deviceType = getDeviceType(MediaQuery.of(context).size);
    if (deviceType != DeviceScreenType.mobile) {
      return Notice(
        url: url,
      );
    }
  }
}
