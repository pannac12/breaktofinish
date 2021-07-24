import 'package:breaktofinish/ko_sf_view.dart';

import 'ko_3_view.dart';
import 'ko_f_view.dart';
import 'ko_page.dart';
import 'sized_text.dart';
import 'package:flutter/material.dart';
import 'constants.dart';

class KOView extends StatefulWidget {
  static const String route = '/ko';

  @override
  _KOViewState createState() => _KOViewState();
}

class _KOViewState extends State<KOView>
    with SingleTickerProviderStateMixin {
  TabController _controller;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 4, vsync: this);

    _controller.addListener(() {
      setState(() {
        _selectedIndex = _controller.index;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(context) => Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.green,
      toolbarHeight: 60, // Set this height
      bottom: TabBar(
        indicatorColor: Colors.white,
        controller: _controller,
        tabs: [
          Tab(child: SizedText(Round.qf)),
          Tab(child: SizedText(Round.semiFinal)),
          Tab(child: SizedText(Round.Final)),
          Tab(child: SizedText(Round.thirdPlace)),
        ],
      ),
    ),
    body: TabBarView(
      controller: _controller,
      children: <Widget>[
        KOPage(Pool.pool_ko, Round.qf),
        KOSFView(),
        KOFView(),
        KO3View(),
      ],
    ),
  );
}

