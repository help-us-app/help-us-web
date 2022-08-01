import 'package:flutter/material.dart';
import 'package:help_us_web/widgets/custom_scroll_body.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../utils/app_colors.dart';

class Notice extends StatelessWidget {
  final String url;
  const Notice({Key key, this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollBody(
        isLoading: false,
        slivers: [
          SliverFillRemaining(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  QrImage(
                    backgroundColor: Colors.white,
                    data: url,
                    version: QrVersions.auto,
                    size: 200,
                  ),
                  const SizedBox(height: 20),
                  RichText(
                    text: TextSpan(
                      text: 'Please scan the QR code on a ',
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                            fontSize: 20,
                          ),
                      children: [
                        TextSpan(
                          text: 'mobile device.',
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
