import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:light_controller_app/Presentation/Screens/User/component/account_screen.dart';
import 'package:light_controller_app/Presentation/Screens/User/component/device_screen.dart';
import 'package:light_controller_app/Presentation/Screens/User/component/history_screen.dart';
import 'package:light_controller_app/Presentation/Screens/User/component/room_screen.dart';
import 'package:light_controller_app/Presentation/Screens/Login/component/background.dart';
import 'package:light_controller_app/Presentation/components/already_have_an_account_acheck.dart';
import 'package:light_controller_app/Presentation/components/rounded_button.dart';
import 'package:light_controller_app/Presentation/components/rounded_input_field.dart';
import 'package:light_controller_app/Presentation/components/rounded_password_field.dart';
import 'package:light_controller_app/constant/constant.dart';


class UserBody extends StatefulWidget {
  @override
  _UserBodyState createState() => _UserBodyState();
}

class _UserBodyState extends State<UserBody> {
  int _currentTabIndex = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
     final _kTabPages = <Widget>[
      AccountScreen(),
      RoomScreen(),
      DeviceScreen(),
      HistoryScreen(),
    ];
    final _kBottmonNavBarItems = <BottomNavigationBarItem>[
      const BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: 'Account'),
      const BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Schedule'),
      const BottomNavigationBarItem(icon: Icon(Icons.meeting_room), label: 'Devices'),
      const BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
    ];
    assert(_kTabPages.length == _kBottmonNavBarItems.length);
    final bottomNavBar = BottomNavigationBar(
      backgroundColor: kButtonColor,
      fixedColor: Colors.black,
      items: _kBottmonNavBarItems,
      currentIndex: _currentTabIndex,
      type: BottomNavigationBarType.fixed,
      onTap: (int index) {
        setState(() {
          _currentTabIndex = index;
        });
      },
    );

    return Scaffold(
      body: _kTabPages[_currentTabIndex],
      bottomNavigationBar: bottomNavBar
    );
  }
}
