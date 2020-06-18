import 'package:flutter/material.dart';
import 'package:integratednithmanagementapp/shared/constants.dart';

class TabItemData {
  const TabItemData({@required this.title, @required this.icon});

  final String title;
  final IconData icon;

  static const Map<TabItem, TabItemData> allTabs = {
    TabItem.home: TabItemData(title: 'Home', icon: Icons.home),
    TabItem.scheduler:
        TabItemData(title: 'Schedule', icon: Icons.calendar_today),
    TabItem.quiz: TabItemData(title: 'Quiz', icon: Icons.question_answer),
    TabItem.attendance:
        TabItemData(title: 'Attendance', icon: Icons.trending_up),
    TabItem.profile: TabItemData(title: 'Profile', icon: Icons.person_outline),
  };
}
