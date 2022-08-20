import 'package:url_launcher/url_launcher_string.dart';

import 'package:flutter/material.dart';
import 'package:help_us_web/pages/items/items_bloc.dart';

import '../../widgets/custom_scroll_body.dart';
import '../../widgets/row.dart';

class Items extends StatefulWidget {
  final String campaignId;
  final String campaignName;
  final String locationId;
  final String userId;
  const Items(
      {Key key,
      this.campaignId,
      this.campaignName,
      this.locationId,
      this.userId})
      : super(key: key);

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
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      child: Scaffold(
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              sliver: SliverList(
                                delegate: SliverChildBuilderDelegate(
                                  (context, index) {
                                    bool isSelected = state.data.selectedItems
                                        .contains(state.data.items[index]);
                                    return ItemRow(
                                      title: state.data.items[index].title,
                                      price: state.data.items[index].price,
                                      image:
                                          state.data.items[index].productImage,
                                      boughtBy:
                                          state.data.items[index].boughtBy,
                                      isPurchased:
                                          state.data.items[index].purchased,
                                      onTap: () async {
                                        if (state.data.items[index].purchased) {
                                          return;
                                        }
                                        if (isSelected) {
                                          await bloc.removeFromSelectedItems(
                                              state.data.items[index]);
                                        } else {
                                          await bloc.addToSelectedItems(
                                              state.data.items[index]);
                                        }
                                        _showSnackBar(
                                            state.data.selectedItems.length,
                                            context);
                                      },
                                      selected: isSelected,
                                    );
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
              })),
    );
  }

  void _showSnackBar(int num, BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    if (num != 0) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "Number of items selected: $num",
        ),
        action: SnackBarAction(
          label: 'Confirm Items',
          onPressed: () async {
            String url =
                await bloc.purchaseItems(widget.userId, widget.locationId);
            if (mounted) {
              _showUrlSnackBar(url, context);
            }
          },
        ),
        duration: const Duration(days: 365),
        dismissDirection: DismissDirection.none,
      ));
    }
  }

  void _showUrlSnackBar(String url, BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text(
        "Items successfully confirmed.",
      ),
      action: SnackBarAction(
        label: 'Complete Purchase',
        onPressed: () {
          launchUrlString(url);
          Navigator.pop(context);
        },
      ),
      duration: const Duration(days: 365),
      dismissDirection: DismissDirection.none,
    ));
  }
}
