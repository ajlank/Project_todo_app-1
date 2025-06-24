import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/utils/constants.dart';

class EmailVerificationCenter extends StatelessWidget {
  const EmailVerificationCenter({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Email Verification center'),
      ),
      body: Column(
        children: [
          const Text("A verification mail has been sent to your email. Please verify it and press the 'Go to Login View'. If you didn't recieve yet, press the following button"),
          TextButton(onPressed: ()async{
            final user=FirebaseAuth.instance.currentUser;
            await user!.sendEmailVerification();
          }, child: const Text('Send a new verification Email')),
          TextButton(onPressed: ()async{
            await FirebaseAuth.instance.signOut();
            Navigator.of(context).pushNamedAndRemoveUntil(loginViewRoute, 
            (_)=>false);

          }, child: const Text('Go to Login View')),
          
        ],
      ),
    );
  }
}