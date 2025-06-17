import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthRegisterView extends StatefulWidget {
  const AuthRegisterView({super.key});

  @override
  State<AuthRegisterView> createState() => _AuthRegisterViewState();
}

class _AuthRegisterViewState extends State<AuthRegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextField(
              controller: _email,
              decoration: InputDecoration(hintText: 'Enter your email'),
            ),
            TextField(
              controller: _password,
              decoration: InputDecoration(hintText: 'Enter your password'),
            ),
            TextButton(
              onPressed: () async {
                final email = _email.text;
                final password = _password.text;
             try{
                 await FirebaseAuth.instance
                    .createUserWithEmailAndPassword(
                      email: email,
                      password: password,
                    );
              final user=FirebaseAuth.instance.currentUser;
              await user!.sendEmailVerification();
              if(context.mounted){
                Navigator.of(context).pushNamedAndRemoveUntil('/loginViewRoute', 
                (route)=>false);
              }
             }on FirebaseAuthException catch (e){
                if (e.code == 'email-already-in-use') {
                  print('email already in use');
                } else if (e.code == 'weak-password') {
                  print('Weak password');
                  
                } else if (e.code == 'invalid-email') {
                  print('invalid email');
                  
                } else {
                  print(e.code);
                }
               }
              },
              child: const Text('Register'),
            ),
            TextButton(
              onPressed: () {
                if (context.mounted) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    '/loginViewRoute',
                    (route) => false,
                  );
                }
              },
              child: const Text('Already registered? login here'),
            ),
          ],
        ),
      ),
    );
  }
}
