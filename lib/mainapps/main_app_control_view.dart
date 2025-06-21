import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/authentication_firebase/auth_login_view.dart';
import 'package:todoapp/authentication_firebase/auth_register_view.dart';
import 'package:todoapp/firebase_options.dart';
import 'package:todoapp/mainapps/my_app.dart';
import 'package:firebase_auth/firebase_auth.dart'
    show FirebaseAuth;
class MainAppControlView extends StatelessWidget {
  const MainAppControlView({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot) {
        switch(snapshot.connectionState){
          case ConnectionState.done:
          final user=FirebaseAuth.instance.currentUser;
          if(user!=null){
            if(user.emailVerified){
              return MyApp();
            }else{
              return AuthRegisterView();
            }
          }else{
            return AuthLoginView();
          }
          
          default:
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
