import 'package:flutter/material.dart';
import 'package:instagram_clone/enums/enums.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({Key key, @required this.items, @required this.selectedItem, @required this.onTap}) : super(key: key);

  final Map<BottomNavItem, IconData> items;
  final BottomNavItem selectedItem;
  final Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
