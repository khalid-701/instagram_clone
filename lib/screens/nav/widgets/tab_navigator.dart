
import 'package:flutter/material.dart';
import 'package:instagram_clone/config/custom_router.dart';
import 'package:instagram_clone/enums/bottom_nav_item.dart';
import 'package:instagram_clone/screens/create/create_screen.dart';
import 'package:instagram_clone/screens/feed/feed_screen.dart';
import 'package:instagram_clone/screens/notification/notification_screen.dart';
import 'package:instagram_clone/screens/profile/profile_screen.dart';
import 'package:instagram_clone/screens/search/search_screen.dart';

class TabNavigator extends StatelessWidget {
  static const String tabNavigatorRoot= '/';
  final GlobalKey<NavigatorState> navigatorKey;
  final BottomNavItem item;
  const TabNavigator({Key key, @required this.navigatorKey, @required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final routeBuilders = _routeBuilders();
    return Navigator(
      key: navigatorKey,
      initialRoute: tabNavigatorRoot,
      onGenerateInitialRoutes: (_, initialRoute){
        return [

          MaterialPageRoute(
            settings: RouteSettings(name: tabNavigatorRoot),
            builder: (context) => routeBuilders[initialRoute](context),)
        ];
      },
      onGenerateRoute: CustomRouter.onGenerateNestedRoute,
    );
  }

  Map<String, WidgetBuilder> _routeBuilders(){
    return {tabNavigatorRoot: (context) => _getScreen(context, item)};
  }
  Widget _getScreen(BuildContext context, BottomNavItem item){
    switch (item){
      case BottomNavItem.feed:
        return FeedScreen();
      case BottomNavItem.search:
        return SearchScreen();
      case BottomNavItem.create:
        return CreateScreen();
      case BottomNavItem.notifications:
        return NotificationScreen();
      case BottomNavItem.profile:
        return ProfileScreen();
      default:
        return Scaffold();
    }
  }
}
