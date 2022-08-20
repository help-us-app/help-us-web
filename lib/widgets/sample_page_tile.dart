import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class SamplePageTile extends StatelessWidget {
  final String title;
  final String url;
  const SamplePageTile({Key key, this.title, this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, url);
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            color: AppColors.secondary,
            width: 300,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
