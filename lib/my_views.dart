import 'package:flutter/material.dart';
import 'package:todoapp/utilities/get_arguments.dart';

class MyViews extends StatefulWidget {
  const MyViews({super.key});

  @override
  State<MyViews> createState() => _MyViewsState();
}

class _MyViewsState extends State<MyViews> {
  @override
  Widget build(BuildContext context) {
   final items=context.getArguments<int>();
    return Scaffold(
      appBar: AppBar(),
      body: Center(child: Text('$items', style: TextStyle(fontSize: 22),)),
    );
  }
}