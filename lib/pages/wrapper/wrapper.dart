import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:help_us_web/pages/dashboard/dashboard.dart';
import 'package:help_us_web/pages/home_page.dart';
import 'package:help_us_web/pages/wrapper/wrapper_bloc.dart';
import 'package:help_us_web/utils/transition.dart';

import '../loading_page.dart';

class Wrapper extends StatefulWidget {
  final String locationId;
  final String userId;

  const Wrapper({Key key, this.locationId, this.userId}) : super(key: key);

  @override
  WrapperState createState() => WrapperState();
}

class WrapperState extends State<Wrapper> {
  WrapperBloc wrapperBloc;

  @override
  void initState() {
    wrapperBloc = WrapperBloc(widget.locationId, widget.userId);
    super.initState();
  }

  @override
  void dispose() {
    wrapperBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: wrapperBloc.stream,
        builder: (context, snapshot) {
          Widget child = const LoadingPage();

          if (snapshot.hasData) {
            WrapperObjectState state = snapshot.data;
            SchedulerBinding.instance.addPostFrameCallback((_) {
              while (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
              Navigator.pushReplacement(
                  context,
                  createRoute(Dashboard(
                    location: state.location,
                    user: state.user,
                    campaigns: state.campaigns,
                  )));
            });
          }

          if (snapshot.hasError) {
            child = const HomePage();
          }

          return child;
        });
  }
}
