import 'package:flutter/material.dart';

const Map<String, IconData> typeIcon = {
  'Class': Icons.book,
  'HomeWork': Icons.format_align_left,
  'Meeting': Icons.group,
  'Assignment': Icons.collections_bookmark,
  'Shopping': Icons.shopping_cart,
};

enum TabItem {
  home,
  scheduler,
  quiz,
  attendance,
  profile,
}
