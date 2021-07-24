import 'ko_page.dart';
import 'sized_text.dart';
import 'package:flutter/material.dart';
import 'constants.dart';

class KO3View extends StatefulWidget {
  static const String route = '/ko_3';

  @override
  _KO3ViewState createState() => _KO3ViewState();
}

class _KO3ViewState extends State<KO3View>
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
        KOPage(Pool.pool_ko, Round.a_3),
        KOPage(Pool.pool_ko, Round.b_3),
      ],
    ),
  );
}

