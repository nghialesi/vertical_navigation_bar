library vertical_navigation_bar;

import 'package:flutter/material.dart';

typedef OnNavigationItemSelected(int index);

class SideNavigationItem {
  final IconData icon;
  final String title;
  bool selected;
  SideNavigationItem(
      {required this.icon, required this.title, this.selected = false});
}

class SideNavigationItemWidget extends StatefulWidget {
  final SideNavigationItem item;
  SideNavigationItemWidget({Key? key, required this.item}) : super(key: key);
  @override
  _SideNavigationItemWidgetState createState() =>
      _SideNavigationItemWidgetState();
}

class _SideNavigationItemWidgetState extends State<SideNavigationItemWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
          border: widget.item.selected
              ? Border(left: BorderSide(color: Colors.red, width: 3.0))
              : Border()),
      child: Padding(
        padding: EdgeInsets.only(top: 25.0, bottom: 25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              widget.item.icon,
              size: 30,
              color: Colors.white,
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                widget.item.title,
                textAlign: TextAlign.center,
                style: theme.primaryTextTheme.bodySmall
                    ?.copyWith(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SideNavigation extends StatefulWidget {
  final List<SideNavigationItem> navItems;
  final OnNavigationItemSelected itemSelected;
  final int initialIndex;
  final List<Widget> actions;
  SideNavigation(
      {Key? key,
      required this.navItems,
      required this.itemSelected,
      required this.initialIndex,
      required this.actions});
  @override
  _SideNavigationState createState() => _SideNavigationState(
      navItems: this.navItems,
      initializeIndex: this.initialIndex,
      actions: this.actions);
}

class _SideNavigationState extends State<SideNavigation> {
  final List<SideNavigationItem> navItems;
  final List<Widget> actions;
  final int initializeIndex;
  var currentIndex;

  _SideNavigationState(
      {required this.navItems,
      required this.initializeIndex,
      required this.actions});

  @override
  void initState() {
    super.initState();
    if (navItems.length > 0 && initializeIndex <= navItems.length) {
      navItems[initializeIndex].selected = true;
      currentIndex = initializeIndex;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return Container(
        decoration: BoxDecoration(
            color: theme.primaryColor,
            boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 6.0)]),
        width: size.width / 13,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ListView.separated(
              separatorBuilder: (context, index) {
                return Divider(
                  color: Colors.white,
                  height: 1.0,
                );
              },
              itemBuilder: (context, index) {
                var item = navItems[index];
                return GestureDetector(
                  child: SideNavigationItemWidget(
                    item: item,
                  ),
                  onTap: () {
                    setState(() {
                      navItems.forEach((item) => item.selected = false);
                      item.selected = true;
                    });
                    if (index != currentIndex) {
                      widget.itemSelected(index);
                      currentIndex = index;
                    }
                  },
                );
              },
              itemCount: navItems.length,
              shrinkWrap: true,
              primary: false,
            ),
            Expanded(
              child: Container(),
            ),
            Container(
              child: ListView.builder(
                  // ignore: unnecessary_null_comparison
                  itemCount: actions == null ? 0 : actions.length,
                  shrinkWrap: true,
                  primary: false,
                  itemBuilder: (context, index) {
                    return actions[index];
                  }),
            )
          ],
        ));
  }
}
