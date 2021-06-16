import 'package:flutter/material.dart';
import 'package:instagram_clone/enums/enums.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar(
      {Key key,
      @required this.items,
      @required this.selectedItem,
      @required this.onTap})
      : super(key: key);

  final Map<BottomNavItem, IconData> items;
  final BottomNavItem selectedItem;
  final Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      onTap: onTap,
      showUnselectedLabels: false,
      backgroundColor: Colors.white,
      selectedItemColor: Theme.of(context).primaryColor,
      unselectedItemColor: Colors.grey,
      currentIndex: BottomNavItem.values.indexOf(selectedItem),
      items: items
          .map(
            (item, icon) => MapEntry(
              item.toString(),
              BottomNavigationBarItem(
                  label: "",
                  icon: Icon(
                    icon,
                    size: 30.0,
                  )),
            ),
          )
          .values
          .toList(),
    );
  }
}
