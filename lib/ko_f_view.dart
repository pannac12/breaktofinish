import 'ko_page.dart';
import 'sized_text.dart';
import 'package:flutter/material.dart';
import 'constants.dart';

class KOFView extends StatefulWidget {
  static const String route = '/ko_f';

  @override
  _KOFViewState createState() => _KOFViewState();
}

class _KOFViewState extends State<KOFView>
    with SingleTickerProviderStateMixin {
  TabController _controller;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);

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
      backgroundColor: Colors.blueGrey,
      toolbarHeight: 60, // Set this height
      bottom: TabBar(
        indicatorColor: Colors.white,
        controller: _controller,
        tabs: [
          Tab(child: SizedText(Round.champion)),
          Tab(child: SizedText(Round.challenger)),
        ],
      ),
    ),
    body: TabBarView(
      controller: _controller,
      children: <Widget>[
        KOPage(Pool.pool_ko, Round.f_a),
        KOPage(Pool.pool_ko, Round.f_b),
      ],
    ),
  );
}

