import 'package:flutter/material.dart';
import 'package:light_controller_app/Presentation/Screens/Admin/admin_screen.dart';
import 'package:light_controller_app/Presentation/Screens/Login/login_screen.dart';
import 'package:light_controller_app/Presentation/Screens/Register/register_screen.dart';


class AppRouter {

  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => LoginScreen(),
        );
        break;
      case '/register':
        return MaterialPageRoute(
          builder: (_) => RegisterScreen(),
        );
        break;
      case '/admin':
        return MaterialPageRoute(
          builder: (_) => AdminScreen(),
        );
        break;
      case '/user':
        return MaterialPageRoute(
          builder: (_) => AdminScreen(),
        );
        break;
      default: return null;
    }
  }
}
