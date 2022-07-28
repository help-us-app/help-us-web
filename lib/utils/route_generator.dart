import 'package:flutter/material.dart';
import 'package:help_us_web/utils/transition.dart';
import '../pages/wrapper/wrapper.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    String url;
    if (settings.name != null) {
      var uriData = Uri.parse(settings.name);
      if (uriData.pathSegments.isNotEmpty) url = uriData.pathSegments.first;
    }
    return createRoute(
      GestureDetector(
        child: Wrapper(
          locationId: url,
        ),
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      ),
    );
  }
}
