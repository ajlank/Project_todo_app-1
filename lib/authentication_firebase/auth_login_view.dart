import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthLoginView extends StatefulWidget {
  const AuthLoginView({super.key});

  @override
  State<AuthLoginView> createState() => _AuthLoginViewState();
}

class _AuthLoginViewState extends State<AuthLoginView> {
   
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email=TextEditingController();
    _password=TextEditingController();
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
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextField(
              controller: _email,
              decoration: InputDecoration(
                hintText: 'Enter your email'
              ),
            ),
            TextField(
              controller: _password,
              decoration: InputDecoration(
                hintText: 'Enter your password'
              ),
              
            ),
            TextButton(onPressed: ()async{
              final email=_email.text;
              final password=_password.text;
            await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
           final user=FirebaseAuth.instance.currentUser;
            if(user!.emailVerified){
                if(context.mounted){
                Navigator.of(context).pushNamedAndRemoveUntil('/myAppViewRoute', 
                (route)=>false);
              }
            } 
            }, child: const Text('Login')),
            TextButton(onPressed: (){
             if(context.mounted){
              Navigator.of(context).pushNamedAndRemoveUntil(
                '/registerViewRoute', (route)=>false);
             }
            }, child: const Text('Not registered yet? register here'))
          ],
        ),
      ),
    );
  }
}