import 'package:flutter/material.dart';
import 'package:help_us_web/utils/transition.dart';
import '../pages/wrapper/wrapper.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    String locationId;
    String userId;
    if (settings.name != null) {
      var uriData = Uri.parse(settings.name);
      if (uriData.pathSegments.isNotEmpty) {
        locationId = uriData.pathSegments.first;
        if (uriData.pathSegments.length > 1) {
          userId = uriData.pathSegments[1];
        }
      }
    }
    return createRoute(
      GestureDetector(
        child: Wrapper(
          locationId: locationId,
          userId: userId,
        ),
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      ),
    );
  }
}
