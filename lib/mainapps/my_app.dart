import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/slidersections/slider_item1.dart';
import 'package:todoapp/slidersections/slider_item2.dart';
import 'package:todoapp/statemanagement/theme_provider.dart';
import 'package:todoapp/utils/cl_dr.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool firstTap=false;
  String myName='Jane';
  late final TextEditingController _textController;
  
  String formatDate(DateTime date){
    return DateFormat('MMMM dd, yyyy').format(date).toUpperCase();
  }
  final now=DateTime.now();
  String get currentDate=>formatDate(now);
  
 @override
  void initState() {
    _textController=TextEditingController();
    super.initState();
  }
  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
  
  final themeIndex=context.watch<ThemeProvider>().getCurrentIndex;

  final backgroundColors=[
    Color(0xFFA8DADC),
    Color(0xFFEDE7F6), 
    Color(0xFFF6D186), 
  ];

    return Scaffold(
      appBar: AppBar(
        title: Text('TODO', style: TextStyle(
          color: defaultColor,
          fontWeight: defaultWeight
        ),),
        centerTitle: true,
        backgroundColor: backgroundColors[themeIndex],
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
      ),
      drawer: Drawer(
        child: IconButton(onPressed: () async {
          await FirebaseAuth.instance.signOut();
          if(context.mounted){
            Navigator.of(context).pushNamedAndRemoveUntil('/loginViewRoute', (_)=>false);
          }
        }, icon: Icon(Icons.logout)),
      ),
      body: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        color: backgroundColors[themeIndex],
     
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 10, 0, 0),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 10, 0, 0),
                    child: CircleAvatar(),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(6, 10, 0, 0),
                    child: GestureDetector(
                        onTap: () {
                        setState(() {
                          firstTap=true;
                        });
                        },
                        child:firstTap? Column(
                          children: [
                            TextField(
                              controller: _textController,
                            ),
                            TextButton(onPressed: () {
                              if(_textController.text.isEmpty){
                                  setState(() {
                              firstTap=false;  
                              });
                                return;
                              }else{
                                 myName=_textController.text;
                              }
                             
                              setState(() {
                              firstTap=false;  
                              });
                              
                            }, child: const Text('Save'))
                          ],
                        ): Text(
                          'Hello, $myName',
                          
                          style: TextStyle(fontSize: 23,color: defaultColor, fontWeight: defaultWeight),
                        ),
                      )
                      
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(6, 10, 0, 0),
                    child: Text('Looks like feel good', style: TextStyle(
                      color:defaultColor,
                      fontWeight: FontWeight.w500
                    ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(6, 3, 0, 0),
                    child: Text('You have 3 tasks to do today',style: TextStyle(
                      color:defaultColor,
                      fontWeight: FontWeight.w500
                    ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(6, 10, 0, 0),
                    child: Text('TODAY: $currentDate', style: TextStyle(
                      color:defaultColor,
                      fontWeight: FontWeight.w500
                    ),),
                  ),
                  SizedBox(height: 60),
                  CarouselSlider(
                    
                    items: [
                      SliderItem1(),
                      SliderItem2()
                    ],
                    options: CarouselOptions(
                      onPageChanged: (index, reason) {
                        setState(() {
                        context.read<ThemeProvider>().setCurrentIndex(index);
                        });
                      },
                      height: 400.00,
                      enlargeCenterPage: true,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
