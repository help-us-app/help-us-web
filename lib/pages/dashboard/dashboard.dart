import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:help_us_web/objects/user.dart';
import 'package:help_us_web/pages/campaigns/campaigns.dart';
import 'package:help_us_web/pages/items/items.dart';
import 'package:help_us_web/utils/notice_display.dart';
import 'package:help_us_web/widgets/custom_scroll_body.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../objects/campaign.dart';
import '../../objects/location.dart';
import '../../utils/const.dart';
import '../../utils/transition.dart';
import '../../widgets/campaign_card.dart';
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
    Widget notice = NoticeDisplay.display(
        "${Constant.webApp}${widget.location.id}/${widget.user.id}", context);
    return notice ??
        Scaffold(
            body: CustomScrollBody(
          isLoading: false,
          slivers: [
            const SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverAppBar(
                backgroundColor: Colors.transparent,
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
                Padding(
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
                          children: [
                            if (widget.location.instagramUsername.isNotEmpty)
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: IconButton(
                                  onPressed: () {
                                    launchUrlString(
                                        '${Constant.instagram}${widget.location.instagramUsername}');
                                  },
                                  icon: const Icon(FontAwesome.instagram,
                                      size: 30),
                                ),
                              ),
                            if (widget.location.facebookUrl.isNotEmpty)
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: IconButton(
                                  onPressed: () {
                                    launchUrlString(
                                        widget.location.facebookUrl);
                                  },
                                  icon: const Icon(FontAwesome.facebook,
                                      size: 30),
                                ),
                              ),
                            if (widget.location.twitterUsername.isNotEmpty)
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: IconButton(
                                  onPressed: () {
                                    launchUrlString(
                                        '${Constant.twitter}${widget.location.twitterUsername}');
                                  },
                                  icon:
                                      const Icon(FontAwesome.twitter, size: 30),
                                ),
                              ),
                            if (widget.location.phoneNumber.isNotEmpty)
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: IconButton(
                                  onPressed: () {
                                    launchUrlString(
                                        'tel:${widget.location.phoneNumber}');
                                  },
                                  icon: const Icon(FontAwesome.phone_square,
                                      size: 30),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ])),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              sliver: SliverToBoxAdapter(
                child: Row(
                  children: [
                    Text(
                      "Campaigns",
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          .copyWith(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(createRoute(Campaigns(
                          campaigns: widget.campaigns,
                          user: widget.user,
                        )));
                      },
                      child: Text("SEE ALL",
                          style: Theme.of(context).textTheme.caption.copyWith(
                              fontSize: 15,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 2)),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return CampaignCard(
                      id: widget.campaigns[index].id.toString(),
                      title: widget.campaigns[index].name,
                      image: widget.campaigns[index].isCompleted
                          ? widget.campaigns[index].completed
                          : widget.campaigns[index].image,
                      description: widget.campaigns[index].description,
                      onTap: () {
                        if (mounted) {
                          Navigator.of(context).push(createRoute(Items(
                            campaignId: widget.campaigns[index].id.toString(),
                            campaignName: widget.campaigns[index].name,
                            locationId: widget.user.locationId,
                            userId: widget.user.id,
                          )));
                        }
                      },
                      isCompleted: widget.campaigns[index].isCompleted,
                    );
                  },
                  childCount:
                      widget.campaigns.length > 3 ? 3 : widget.campaigns.length,
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 30,
              ),
            )
          ],
        ));
  }
}
