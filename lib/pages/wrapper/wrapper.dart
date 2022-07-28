import 'package:flutter/material.dart';
import 'package:help_us_web/pages/wrapper/wrapper_bloc.dart';

import '../loading_page.dart';

class Wrapper extends StatefulWidget {
  final String locationId;

  const Wrapper({Key key, this.locationId}) : super(key: key);

  @override
  WrapperState createState() => WrapperState();
}

class WrapperState extends State<Wrapper> {
  WrapperBloc wrapperBloc;

  @override
  void initState() {
    wrapperBloc = WrapperBloc(widget.locationId);
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
        stream: wrapperBloc.location,
        builder: (context, snapshot) {
          Widget child = const LoadingPage();

          if (snapshot.hasData) {
            child = Container(
              color: Colors.green,
            );
          }

          if (snapshot.hasError) {
            child = Container(
              color: Colors.red,
            );
          }

          return child;
        });
  }
}
