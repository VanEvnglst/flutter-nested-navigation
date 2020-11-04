import 'package:flutter/material.dart';
import 'package:nav_update/bottom_navigation.dart';
import 'package:nav_update/tab_navigator.dart';

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AppState();
}

class AppState extends State<App> {
  // current tab
  TabItem _currentTab = TabItem.red;

  // define navigator keys
  Map<TabItem, GlobalKey<NavigatorState>> _navigatorKeys = {
    TabItem.red: GlobalKey<NavigatorState>(),
    TabItem.green: GlobalKey<NavigatorState>(),
    TabItem.blue: GlobalKey<NavigatorState>(),
  };

  //function for selecting tabs
  void _selectTab(TabItem tabItem) {
    if (tabItem == _currentTab) {
      // pop to first route
      //_navigatorKeys[tabItem].currentState.popUntil((route) => route.isFirst);
    } else {
      setState(() => _currentTab = tabItem);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return WillPopScope(
        onWillPop: () async {
          final isFirstRouteInCurrentTab = !await _navigatorKeys[_currentTab].currentState.maybePop();
          if (isFirstRouteInCurrentTab) {
            // checker if not [main] tab
            if (_currentTab != TabItem.red) {
              // select [main] tab
              _selectTab(TabItem.red);
              // back button handled by app
              return false;
            }
          }
          // let system handle back button if we're on the first route
          return isFirstRouteInCurrentTab;
        },
        child: Scaffold(
          body: screenWidth < 1200
              ? Row(
                  children: [
                    Container(
                        color: Colors.amber,
                        width: 200,
                        child: ListView(
                          children: [
                            ListTile(
                              onTap: () => _selectTab(TabItem.red),
                              title: Text('Red'),
                            ),
                            ListTile(
                              onTap: () => _selectTab(TabItem.green),
                              title: Text('Green'),
                            ),
                            ListTile(
                              onTap: () => _selectTab(TabItem.blue),
                              title: Text('Blue'),
                            ),
                          ],
                        )),
                    Expanded(
                      child: Stack(
                        children: [
                          _buildOffstageNavigator(TabItem.red),
                          _buildOffstageNavigator(TabItem.green),
                          _buildOffstageNavigator(TabItem.blue),
                        ],
                      ),
                    ),
                  ],
                )
              : Stack(
                  children: [
                    _buildOffstageNavigator(TabItem.red),
                    _buildOffstageNavigator(TabItem.green),
                    _buildOffstageNavigator(TabItem.blue),
                  ],
                ),
          bottomNavigationBar: screenWidth < 1200
              ? null
              : BottomNavigation(
                  currentTab: _currentTab,
                  onSelectTab: _selectTab,
                ),
        ));
  }

  Widget _buildOffstageNavigator(TabItem tabItem) {
    print('offstage $tabItem');
    return Offstage(
        offstage: _currentTab != tabItem,
        child: TabNavigator(
          navigatorKey: _navigatorKeys[tabItem],
          tabItem: tabItem,
        ));
  }
}
