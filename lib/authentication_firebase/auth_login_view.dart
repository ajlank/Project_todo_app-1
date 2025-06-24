import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/statemanagement/family_task_note_provider.dart';
import 'package:todoapp/utils/constants.dart';

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
      appBar: AppBar(title: const Text(''), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Consumer<FamilyTaskNoteProvider>(
          builder: (context, value, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Login',
                style: TextStyle(
                  fontSize: 22
                ),
              ),
              TextField(
                controller: _email,
                decoration: InputDecoration(hintText: 'Enter your email'),
              ),
             Text((value.errorTextEmail.isNotEmpty)?value.getErrorMessageEmail:'',style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.w400
              ),),
              TextField(
                controller: _password,
                decoration: InputDecoration(hintText: 'Enter your password'),
              ),
              Text((value.errorTextPassword.isNotEmpty)?value.getErrorMessagePass:'',style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.w400
              ),),
              TextButton(
                onPressed: () async {
                  final email = _email.text;
                  final password = _password.text;
               try{
                   await FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                        email: email,
                        password: password,
                      );
                final user=FirebaseAuth.instance.currentUser;
                
                if(user!.emailVerified){
                  Navigator.of(context).pushNamedAndRemoveUntil(myAppViewRoute, (route)=>false);
                }
               }on FirebaseAuthException catch (e){
                  if (e.code == 'user-not-found') {
                  if(context.mounted){
                      context.read<FamilyTaskNoteProvider>().addErrorTextEmaikl('user not found');
                  
                  }
                  } else if (e.code == 'wrong-password') {
                   if(context.mounted){
                      context.read<FamilyTaskNoteProvider>().addErrorTextPassword('wrong password');
                  }
                    
                  }else {
                    if(context.mounted){
                      context.read<FamilyTaskNoteProvider>().addErrorTextEmaikl('Error: $e');
                  }
                  }
                 }
                },
                child: const Text('Login'),
              ),
              TextButton(
                onPressed: () {
                  if (context.mounted) {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      registerViewRoute,
                      (route) => false,
                    );
                  }
                },
                child: const Text('Not registered yet? register here'),
              ),
            ],
          );   
          },
          
        ),
      ),
    );
  }
}