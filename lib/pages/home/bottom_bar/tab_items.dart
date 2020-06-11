import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum TabItem { home, calender, profile, statistics, notification }

class TabItemData {
  const TabItemData({@required this.title, @required this.icon});

  final String title;
  final IconData icon;

  static const Map<TabItem, TabItemData> allTabs = {
    TabItem.home: TabItemData(title: 'Home', icon: Icons.home),
    TabItem.calender: TabItemData(title: 'Schedule', icon: Icons.calendar_today),
    TabItem.profile: TabItemData(title: 'Profile', icon: Icons.person_outline),
    TabItem.statistics: TabItemData(title: 'Statistic', icon: Icons.equalizer),
    TabItem.notification: TabItemData(title: 'Notification', icon: Icons.notifications_none),
  };
}