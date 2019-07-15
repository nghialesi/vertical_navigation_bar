# vertical_navigation_bar

A simple vertical navigation bar for Flutter app

## Demo

![alt text](https://github.com/nghialesi/vertical_navigation_bar/blob/master/example/ScreenShot.png)

## How to use it?

**1. Install**
```yaml
dependencies:
  vertical_navigation_bar: ^0.0.1
```

**2. Run flutter command**
```
flutter pub get
```

## Sample code

**1. Step 1**
 Because I'm using PageView to wrap content, so we need to add some lines of initial code below. 
```dart
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
```

**2. Step 2**
 Build method
```dart
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
              //add some action button here
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
```

