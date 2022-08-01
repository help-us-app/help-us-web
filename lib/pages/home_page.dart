import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:help_us_web/widgets/custom_scroll_body.dart';

import '../utils/app_colors.dart';
import '../widgets/help_us_logo.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollBody(
        isLoading: false,
        slivers: [
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 20),
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
                      text: TextSpan(
                        text: 'Please access through a ',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(
                          fontSize: 20,
                        ),
                        children: [
                          TextSpan(
                            text: 'participating business',
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
