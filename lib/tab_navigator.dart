import 'package:flutter/material.dart';
import 'package:nav_update/bottom_navigation.dart';
import 'package:nav_update/color_details_page.dart';
import 'package:nav_update/colors_list_page.dart';

class TabNavigatorRoutes {
  static const String root = '/';
  static const String detail = '/detail';
}

class TabNavigator extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final TabItem tabItem;

  TabNavigator({Key key, this.navigatorKey, this.tabItem}) : super(key: key);

  void _push(BuildContext context, {int materialIndex: 500}) {
    var routeBuilders = _routeBuilders(context, materialIndex: materialIndex);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => routeBuilders[TabNavigatorRoutes.detail](context),
      ),
    );
  }

  Map<String, WidgetBuilder> _routeBuilders(BuildContext context, {int materialIndex: 500}) {
    return {
      TabNavigatorRoutes.root: (context) => ColorsListPage(
        color: activeTabColor[tabItem],
        title: tabName[tabItem],
        onPush: (materialIndex) =>
          _push(context, materialIndex: materialIndex),
      ),
      TabNavigatorRoutes.detail: (context) => ColorDetailPage(
        color: activeTabColor[tabItem],
        title: tabName[tabItem],
        materialIndex: materialIndex,
      )
    };
  }
  @override
  Widget build(BuildContext context) {
    final routeBuilders = _routeBuilders(context);
    return Navigator(
      key: navigatorKey,
      initialRoute: TabNavigatorRoutes.root,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
          builder: (context) => routeBuilders[routeSettings.name](context),
        );
      }      
    );
  }
}