import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:help_us_web/pages/items/items_bloc.dart';

import '../../widgets/custom_scroll_body.dart';
import '../../widgets/row.dart';

class Items extends StatefulWidget {
  final String campaignId;
  final String campaignName;
  const Items({Key key, this.campaignId, this.campaignName}) : super(key: key);

  @override
  State<Items> createState() => _ItemsState();
}

class _ItemsState extends State<Items> {
  ItemsBloc bloc;

  @override
  void initState() {
    bloc = ItemsBloc(widget.campaignId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<ItemsObjectState>(
            stream: bloc.stream,
            builder: (context, state) {
              return CustomScrollBody(
                  isLoading: !state.hasData || state.data.isLoading,
                  slivers: state.hasData
                      ? [
                          SliverAppBar(
                            floating: true,
                            snap: true,
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                            flexibleSpace: FlexibleSpaceBar(
                              title: Text(widget.campaignName),
                              centerTitle: true,
                            ),
                          ),
                          SliverPadding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            sliver: SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (context, index) {
                                  log(state.data.items[index]
                                      .toJson()
                                      .toString());
                                  return ItemRow(
                                      title: state.data.items[index].title,
                                      price: state.data.items[index].price,
                                      image:
                                          state.data.items[index].productImage,
                                      isPurchased:
                                          state.data.items[index].purchased,
                                      onTap: () {});
                                },
                                childCount: state.data.items.length,
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
