import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import '../screens/calender.dart';
import '../screens/goals.dart';
import '../screens/home.dart';
import '../screens/user_details.dart';
import '../screens/write.dart';
import 'package:flutter/material.dart';

class Notchbar extends StatefulWidget {
  const Notchbar({super.key});

  @override
  NotchbarState createState() => NotchbarState();
}

class NotchbarState extends State<Notchbar> {
  final NotchBottomBarController _controller =
      NotchBottomBarController(index: 2);
  final List<Widget> _pages = [
    const Write(),
    const Calender(),
    const HomeScreeen(),
    const Goals(),
    const UserDetails()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_controller.index],
      bottomNavigationBar: AnimatedNotchBottomBar(
        notchBottomBarController: _controller,
        bottomBarItems: const [
          BottomBarItem(
            inActiveItem:
                Image(image: AssetImage('assets/icons/pencil.png')),
            activeItem: Image(image: AssetImage('assets/icons/pencil.png')),
          ),
          BottomBarItem(
            inActiveItem:
                Image(image: AssetImage('assets/icons/calendar.png')),
            activeItem:
                Image(image: AssetImage('assets/icons/calendar.png')),
          ),
          BottomBarItem(
            inActiveItem: Image(image: AssetImage('assets/icons/home.png')),
            activeItem: Image(image: AssetImage('assets/icons/home.png')),
          ),
          BottomBarItem(
            inActiveItem:
                Image(image: AssetImage('assets/icons/stats.png')),
            activeItem: Image(image: AssetImage('assets/icons/stats.png')),
          ),
          BottomBarItem(
              inActiveItem: Image(
                image: AssetImage('assets/icons/user.png'),
                width: 100,
                height: 100,
              ),
              activeItem:
                  Image(image: AssetImage('assets/icons/user.png'))),
        ],
        onTap: (index) {
          setState(() {
            _controller.index = index;
          });
        },
        kIconSize: 25,
        kBottomRadius: 30,
        bottomBarHeight: 60,
        color: const Color.fromRGBO(217, 217, 217, 1),
        notchColor: const Color.fromRGBO(194, 246, 58, 1),
        shadowElevation: 5,
        showTopRadius: true,
      ),
    );
  }
}
