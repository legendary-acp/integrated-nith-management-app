import 'package:flutter/material.dart';

import 'package:integratednithmanagementapp/pages/home/bottom_bar/tab_items.dart';
import 'package:integratednithmanagementapp/shared/constants.dart';


class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    @required this.currentTab,
    @required this.onSelectTab,
    @required this.widgetBuilders,
  });

  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;
  final Map<TabItem, WidgetBuilder> widgetBuilders;

  BottomNavigationBarItem _buildItem(TabItem tabItem) {
    final itemData = TabItemData.allTabs[tabItem];
    final color = currentTab == tabItem ? Colors.indigo : Colors.grey;
    return BottomNavigationBarItem(
      icon: Icon(
        itemData.icon,
        color: color,
      ),
      title: Text(
        itemData.title,
        style: TextStyle(
          color: color,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        _buildItem(TabItem.home),
        _buildItem(TabItem.scheduler),
        _buildItem(TabItem.quiz),
        _buildItem(TabItem.notification),
        _buildItem(TabItem.profile),
      ],
      onTap: (index) => onSelectTab(TabItem.values[index]),
      currentIndex: currentTab.index,
    );
  }
}
