import 'package:flutter/material.dart';
import 'package:integratednithmanagementapp/pages/home/bottom_bar/tab_items.dart';
import 'package:integratednithmanagementapp/pages/home/scheduler/scheduler.dart';
import 'package:integratednithmanagementapp/pages/home/profile/profile.dart';

import 'bottom_bar/bottom_bar.dart';
import 'home_main/home_main.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TabItem _currentTab = TabItem.calender;

  void _select(TabItem tabItem) {
    setState(() {
      if (tabItem == _currentTab)
        navigatorKey[tabItem].currentState.popUntil((route) => route.isFirst);
      else
        _currentTab = tabItem;
    });
  }

  final Map<TabItem, GlobalKey<NavigatorState>> navigatorKey = {
    TabItem.home: GlobalKey<NavigatorState>(),
    TabItem.calender: GlobalKey<NavigatorState>(),
    TabItem.profile: GlobalKey<NavigatorState>(),
    TabItem.statistics: GlobalKey<NavigatorState>(),
    TabItem.notification: GlobalKey<NavigatorState>(),
  };

  Map<TabItem, WidgetBuilder> get widgetBuilders {
    return {
      TabItem.home: (_) => Home(),
      TabItem.calender: (_) => Scheduler(),
      TabItem.profile: (_) => Profile(),
      TabItem.statistics: (_) => Home(),
      TabItem.notification: (_) => Home(),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widgetBuilders[_currentTab](context),
      bottomNavigationBar: BottomNavBar(
      onSelectTab: _select,
        currentTab: _currentTab,
        widgetBuilders: widgetBuilders,
      ),
    );
  }
}
