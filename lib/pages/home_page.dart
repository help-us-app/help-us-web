import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:help_us_web/widgets/custom_scroll_body.dart';
import 'package:help_us_web/widgets/sample_page_tile.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../utils/app_colors.dart';
import '../widgets/help_us_logo.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DeviceScreenType deviceType = getDeviceType(MediaQuery.of(context).size);

    return Scaffold(
      body: CustomScrollBody(
        isLoading: false,
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const HelpUsLogo(
                      fontSize: 50,
                    ),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: 'Please select a ',
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                              fontSize: 20,
                            ),
                        children: [
                          TextSpan(
                            text: 'sample page created by us.',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .copyWith(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primary),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Flex(
                      direction: deviceType == DeviceScreenType.mobile ||
                              deviceType == DeviceScreenType.tablet
                          ? Axis.vertical
                          : Axis.horizontal,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        SamplePageTile(
                          title: "Maxfield Park Children's Home",
                          url:
                              "/L25XN29GTJ3NE/439b74a0-9db9-4355-9b55-cc704ec29751",
                        ),
                        SamplePageTile(
                          title: "Dream Beach Cleaners",
                          url:
                              "/LEHA8Z7T4STA0/439b74a0-9db9-4355-9b55-cc704ec29751",
                        ),
                        SamplePageTile(
                          title: "Plant a Tree Foundation",
                          url:
                              "/LNE78VB44ADJW/439b74a0-9db9-4355-9b55-cc704ec29751",
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
