import 'package:flutter/material.dart';

import 'package:integratednithmanagementapp/pages/home/notification/notification.dart';
import 'package:integratednithmanagementapp/pages/home/quiz/quiz_main.dart';
import 'package:integratednithmanagementapp/pages/home/scheduler/scheduler.dart';
import 'package:integratednithmanagementapp/pages/home/profile/profile.dart';
import 'package:integratednithmanagementapp/shared/constants.dart';
import 'package:integratednithmanagementapp/pages/home/bottom_bar/bottom_bar.dart';
import 'package:integratednithmanagementapp/pages/home/home_main/home_main.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TabItem _currentTab = TabItem.scheduler;

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
    TabItem.scheduler: GlobalKey<NavigatorState>(),
    TabItem.quiz: GlobalKey<NavigatorState>(),
    TabItem.notification: GlobalKey<NavigatorState>(),
    TabItem.profile: GlobalKey<NavigatorState>(),
  };

  Map<TabItem, WidgetBuilder> get widgetBuilders {
    return {
      TabItem.home: (_) => Home(),
      TabItem.scheduler: (_) => Scheduler.create(context),
      TabItem.quiz: (_) => Quiz(),
      TabItem.notification: (_) => Notifications(),
      TabItem.profile: (_) => Profile(),
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
