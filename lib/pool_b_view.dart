import 'rr_page.dart';
import 'sized_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'constants.dart';

class PoolBView extends StatefulWidget {
  static const String route = '/pool_b';

  @override
  _PoolBViewState createState() => _PoolBViewState();
}

class _PoolBViewState extends State<PoolBView>
    with SingleTickerProviderStateMixin {
  TabController _controller;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 5, vsync: this);

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
          Tab(child: SizedText(Round.round_1)),
          Tab(child: SizedText(Round.round_2)),
          Tab(child: SizedText(Round.round_3)),
          Tab(child: SizedText(Round.round_4)),
          Tab(child: SizedText(Round.round_5)),
        ],
      ),
    ),
    body: TabBarView(
      controller: _controller,
      children: <Widget>[
        RRPage(Pool.pool_b, Round.round_1),
        RRPage(Pool.pool_b, Round.round_2),
        RRPage(Pool.pool_b, Round.round_3),
        RRPage(Pool.pool_b, Round.round_4),
        RRPage(Pool.pool_b, Round.round_5),
      ],
    ),
  );
}

