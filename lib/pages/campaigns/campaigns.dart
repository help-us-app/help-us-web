import 'package:flutter/material.dart';
import 'package:help_us_web/objects/user.dart';
import 'package:help_us_web/pages/campaigns/campaigns_bloc.dart';

import '../../objects/campaign.dart';
import '../../utils/transition.dart';
import '../../widgets/campaign_card.dart';
import '../../widgets/custom_scroll_body.dart';
import '../items/items.dart';

class Campaigns extends StatefulWidget {
  final List<Campaign> campaigns;
  final User user;
  const Campaigns({Key key, this.campaigns, this.user}) : super(key: key);

  @override
  State<Campaigns> createState() => _CampaignsState();
}

class _CampaignsState extends State<Campaigns> {
  CampaignsBloc bloc;

  @override
  void initState() {
    bloc = CampaignsBloc(widget.campaigns);
    super.initState();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<CampaignsObjectState>(
            stream: bloc.stream,
            builder: (context, state) {
              return CustomScrollBody(
                  isLoading: !state.hasData || state.data.isLoading,
                  slivers: state.hasData
                      ? [
                          const SliverAppBar(
                            floating: true,
                            snap: true,
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                            flexibleSpace: FlexibleSpaceBar(
                              title: Text("All Campaigns"),
                              centerTitle: true,
                            ),
                          ),
                          SliverPadding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            sliver: SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (context, index) {
                                  return CampaignCard(
                                    id: state.data.campaigns[index].id
                                        .toString(),
                                    title: state.data.campaigns[index].name,
                                    image: state.data.campaigns[index].image,
                                    description:
                                        state.data.campaigns[index].description,
                                    onTap: () {
                                      if (mounted) {
                                        Navigator.of(context)
                                            .push(createRoute(Items(
                                          campaignId: state
                                              .data.campaigns[index].id
                                              .toString(),
                                          campaignName:
                                              state.data.campaigns[index].name,
                                          locationId: widget.user.locationId,
                                          userId: widget.user.id,
                                        )));
                                      }
                                    },
                                    isCompleted:
                                        state.data.campaigns[index].isCompleted,
                                  );
                                },
                                childCount: state.data.campaigns.length,
                              ),
                            ),
                          ),
                          const SliverToBoxAdapter(
                            child: SizedBox(
                              height: 30,
                            ),
                          )
                        ]
                      : []);
            }));
  }
}
