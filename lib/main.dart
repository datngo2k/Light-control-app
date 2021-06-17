import 'package:connectivity/connectivity.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:light_controller_app/Logic/Auth/cubit/auth_cubit.dart';
import 'package:light_controller_app/Logic/Internet/internet_cubit.dart';
import 'package:light_controller_app/Logic/LightControl/cubit/lightcontrol_cubit.dart';
import 'package:light_controller_app/Logic/Register/cubit/register_cubit.dart';
import 'package:light_controller_app/Logic/User/cubit/user_cubit.dart';
import 'package:light_controller_app/Presentation/Routes/app-router.dart';
import 'package:light_controller_app/constant/constant.dart';
import 'package:logging/logging.dart';
import 'package:stack_trace/stack_trace.dart';
import 'Logic/Action/cubit/action_cubit.dart';
import 'Logic/Room/cubit/room_cubit.dart';
import 'Logic/Schedule/cubit/schedule_cubit.dart';
void initLogger() {
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((LogRecord rec) {
      final List<Frame> frames = Trace.current().frames;
      try {
        final Frame f = frames.skip(0).firstWhere((Frame f) =>
            f.library.toLowerCase().contains(rec.loggerName.toLowerCase()) &&
            f != frames.first);
        print(
            '${rec.level.name}: ${f.member} (${rec.loggerName}:${f.line}): ${rec.message}');
      } catch (e) {
        print(e.toString());
      }
    });
  }
void main() async {
  initLogger();
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
        BlocProvider<UserCubit>(
          create: (context) => UserCubit(),
        ),
        BlocProvider<RoomCubit>(
          create: (context) => RoomCubit(),
        ),
        BlocProvider<ScheduleCubit>(
          create: (context) => ScheduleCubit(),
        ),
        BlocProvider<LightcontrolCubit>(
          create: (context) => LightcontrolCubit(),
        ),
        BlocProvider<ActionCubit>(
          create: (context) => ActionCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Light Controller App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          backgroundColor: kBackgroundColor
        ),
        onGenerateRoute: appRouter.onGenerateRoute,
        builder: EasyLoading.init(),
      ),
    );
  }
}
