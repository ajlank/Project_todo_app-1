import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/statemanagement/family_task_note_provider.dart';
import 'package:todoapp/utils/constants.dart';

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
      appBar: AppBar(title: const Text(''), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Consumer<FamilyTaskNoteProvider>(
          builder: (context, value, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Register',
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
                      .createUserWithEmailAndPassword(
                        email: email,
                        password: password,
                      );
                final user=FirebaseAuth.instance.currentUser;
                await user!.sendEmailVerification();
                if(context.mounted){
                  Navigator.of(context).pushNamed(emailVerificationViewRoute);
                }
               }on FirebaseAuthException catch (e){
                  if (e.code == 'email-already-in-use') {
                  if(context.mounted){
                      context.read<FamilyTaskNoteProvider>().addErrorTextEmaikl('email already in use');
                  
                  }
                  } else if (e.code == 'weak-password') {
                   if(context.mounted){
                      context.read<FamilyTaskNoteProvider>().addErrorTextPassword('weak password');
                  }
                    
                  } else if (e.code == 'invalid-email') {
                  if(context.mounted){
                      context.read<FamilyTaskNoteProvider>().addErrorTextEmaikl('Invalid Email');
                      
                  }
                    
                  } else {
                    if(context.mounted){
                      context.read<FamilyTaskNoteProvider>().addErrorTextEmaikl('Error: $e');
                  }
                  }
                 }
                },
                child: const Text('Register'),
              ),
              TextButton(
                onPressed: () {
                  if (context.mounted) {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      loginViewRoute,
                      (route) => false,
                    );
                  }
                },
                child: const Text('Already registered? login here'),
              ),
            ],
          );   
          },
          
        ),
      ),
    );
  }
}
