import 'package:connectivity/connectivity.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:light_controller_app/Logic/Auth/cubit/auth_cubit.dart';
import 'package:light_controller_app/Logic/Internet/internet_cubit.dart';
import 'package:light_controller_app/Logic/Register/cubit/register_cubit.dart';
import 'package:light_controller_app/Presentation/Routes/app-router.dart';
import 'package:light_controller_app/Presentation/Screens/Login/login_screen.dart';

void main() async {
  AppRouter appRouter = AppRouter();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp(
    appRouter: appRouter,
    connectivity: Connectivity(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final AppRouter appRouter;
  final Connectivity connectivity;

  MyApp({@required this.appRouter, @required this.connectivity});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<InternetCubit>(
          create: (context) => InternetCubit(connectivity: connectivity),
        ),
        BlocProvider<RegisterCubit>(
          create: (context) => RegisterCubit(),
        ),
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'Light Controller App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        onGenerateRoute: appRouter.onGenerateRoute,
      ),
    );
  }
}
