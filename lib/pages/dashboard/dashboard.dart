import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:help_us_web/objects/user.dart';
import 'package:help_us_web/widgets/custom_scroll_body.dart';

import '../../objects/campaign.dart';
import '../../objects/location.dart';
import '../../widgets/help_us_logo.dart';

class Dashboard extends StatefulWidget {
  final Location location;
  final User user;
  final List<Campaign> campaigns;
  const Dashboard({Key key, this.location, this.user, this.campaigns})
      : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollBody(
      isLoading: false,
      slivers: [
        const SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          sliver: SliverAppBar(
            leading: SizedBox.shrink(),
            title: HelpUsLogo(
              hasForChrome: true,
              fontSize: 30,
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
          ),
          sliver: SliverToBoxAdapter(
            child: Image.network(
              widget.location.logoUrl,
              height: 250,
              width: 250,
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          sliver: SliverList(
              delegate: SliverChildListDelegate.fixed([
            Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(widget.location.businessName,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline5.copyWith(
                            fontSize: 30, fontWeight: FontWeight.bold)),
                    Text(widget.location.address.addressLine1,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.caption.copyWith(
                            fontSize: 20, fontWeight: FontWeight.w200)),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(FontAwesome.instagram, size: 30),
                          SizedBox(width: 10),
                          Icon(FontAwesome.twitter, size: 30),
                          SizedBox(width: 10),
                          Icon(FontAwesome.facebook, size: 30),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ])),
        )
      ],
    ));
  }
}
