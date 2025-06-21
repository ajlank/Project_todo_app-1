import 'package:flutter/material.dart';
import 'package:todoapp/authentication_firebase/auth_login_view.dart';
import 'package:todoapp/authentication_firebase/auth_register_view.dart';
import 'package:todoapp/mainapps/main_app_control_view.dart';
import 'package:todoapp/mainapps/my_app.dart';
import 'package:todoapp/utils/constants.dart';
import 'package:todoapp/views/personal_view.dart';
import 'package:todoapp/views/work_view.dart';
import 'package:todoapp/writingView/write_personal.dart';
import 'package:todoapp/writingView/write_work.dart';

class RootAPP extends StatelessWidget {
  const RootAPP({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white10),
          brightness: Brightness.light 
        ),
           
        home:MainAppControlView(),
        routes: {
          personalViewRoute: (context) => PersonalView(),
          workViewRoute:(context)=>WorkView(),
           writePersonalViewRoute:(context)=> WritePersonal(),
           writeWorkViewRoute:(context)=>WriteWork(),
           registerViewRoute:(context)=>AuthRegisterView(),
           loginViewRoute:(context)=>AuthLoginView(),
           myAppViewRoute:(context)=>MyApp(),
          },
      );
  }
}
