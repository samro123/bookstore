import 'package:appbook/module/home/home_page.dart';
import 'package:appbook/shared/widget/app_color.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

class MenuBottom extends StatefulWidget {
  const MenuBottom({Key? key}) : super(key: key);

  @override
  State<MenuBottom> createState() => _MenuBottomState();
}

class _MenuBottomState extends State<MenuBottom> {
  int _selectedIndex = 0 ;
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const  List<Widget> _widget = <Widget>[
    Home(),
    Text("Like", style: optionStyle,),
    Text("Profile", style: optionStyle,),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: _widget.elementAt(_selectedIndex),
        ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(0.1)
            )
          ]
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: AppColor.green,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              tabBackgroundColor: Colors.grey[100]!,
              color: Colors.black,
              tabs: [
                  GButton(icon: LineIcons.home, text: 'Home',),
                  GButton(icon: LineIcons.heart, text: 'Likes',),
                  GButton(icon: LineIcons.user, text: 'Profiles',),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
              },
            ),
          ),
        ),
      ),
    );
  }
}
