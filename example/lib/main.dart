import 'package:flutter/material.dart';
import 'package:vertical_navigation_bar/vertical_navigation_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vertical navigation bar demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final pageController = PageController(
      initialPage: 0,
      keepPage: true
  );

  final navItems = [
    SideNavigationItem(icon: FontAwesomeIcons.calendarCheck, title: "New task"),
    SideNavigationItem(icon: FontAwesomeIcons.calendarAlt, title: "Personal task"),
    SideNavigationItem(icon: FontAwesomeIcons.fileAlt, title: "Personal document"),
    SideNavigationItem(icon: FontAwesomeIcons.calendar, title: "Company task"),
    SideNavigationItem(icon: FontAwesomeIcons.arrowCircleRight, title: "Options")
  ];
  final initialTab = 0;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: <Widget>[
          SideNavigation(
            navItems: this.navItems,
            itemSelected: (index){
              pageController.animateToPage(
                  index,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.linear
              );
            },
            initialIndex: 0,
            actions: <Widget>[

            ],
          ),
          Expanded(
            child: PageView.builder(
              itemCount: 5,
              controller: pageController,
              scrollDirection: Axis.vertical,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index){
                return Container(
                    color: Colors.blueGrey.withOpacity(0.1),
                    child: Center(
                      child: Text("Page " + index.toString()),
                    )
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
