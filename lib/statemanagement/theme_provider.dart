import 'package:flutter/material.dart';

final List<ThemeData>themes=[
 
 ThemeData(
 brightness: Brightness.light,
 

 ),
 ThemeData(
  brightness: Brightness.dark,
 

 ),
 ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.green,

 )
];


class ThemeProvider extends ChangeNotifier{
  int _currentIndex=0;
  int get getCurrentIndex=>_currentIndex;
   
  ThemeData get currentTheme=>themes[_currentIndex];
 
  void setCurrentIndex(int indx){
    _currentIndex=indx;
    notifyListeners();
  }
  
  
}
