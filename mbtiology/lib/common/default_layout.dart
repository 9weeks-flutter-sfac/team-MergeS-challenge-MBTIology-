import 'package:flutter/material.dart';
import 'package:mbtiology/common/const.dart';

class DefaultLayout extends StatelessWidget {
  final Widget body;
  final AppBar? appBar;

  const DefaultLayout({
    required this.body,
    this.appBar,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommonValue.paperColor,
      appBar: appBar,
      body: Padding(
        padding: const EdgeInsets.all(CommonValue.commonPadding),
        child: body,
      ),
    );
  }
}
