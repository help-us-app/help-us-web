import 'package:flutter/material.dart';

import 'custom_scroll_body.dart';

class PhotoView extends StatelessWidget {
  final String imageUrl;
  const PhotoView({Key key, this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
          body: CustomScrollBody(
        isLoading: false,
        slivers: [
          const SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverAppBar(),
          ),
          SliverFillRemaining(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: imageUrl,
                child: Image.network(
                  imageUrl,
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ))
        ],
      )),
    );
  }
}
