import 'dart:collection';
// import 'dart:convert' as convert;
import 'package:todoapp/cloud/cloud_note.dart';
import 'package:todoapp/cloud/firebase_cloud_storage.dart';

import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
// import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:todoapp/authentication_firebase/auth_login_view.dart';
import 'package:todoapp/authentication_firebase/auth_register_view.dart';
import 'package:todoapp/views/personal_view.dart';
import 'package:todoapp/writingView/write_personal.dart';
import 'package:firebase_auth/firebase_auth.dart'
    show FirebaseAuth;
import 'package:intl/intl.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
   
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
        create: (context) =>PersonalNoteProvider()
        ),
        ChangeNotifierProvider(
        create: (context) =>ThemeProvider()
        ),
      ],
     child: RootAPP(),
    )
   
  );
}


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


class RootAPP extends StatelessWidget {
  const RootAPP({super.key});

  @override
  Widget build(BuildContext context) {
    return  Consumer<ThemeProvider>(
      builder: (context, value, child) {
        return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: value.currentTheme,
           
        home:MainAppControlView(),
        routes: {
          '/personalView': (context) => PersonalView(),
           '/writePersonal':(context)=> WritePersonal(),
           '/registerViewRoute':(context)=>AuthRegisterView(),
           '/loginViewRoute':(context)=>AuthLoginView(),
           '/myAppViewRoute':(context)=>MyApp()
          },
      );
      }, 
    );
  }
}


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


class PersonalNoteProvider extends ChangeNotifier{

   final FirebaseCloudStorage cloudStorage=FirebaseCloudStorage();
 
   final List<CloudNote> _notes=[];

  
   UnmodifiableListView<dynamic> get items => UnmodifiableListView(_notes);
  
   Future<CloudNote>createNewNote({required String text})async{
    final userId=FirebaseAuth.instance.currentUser!.uid;
    final newNotes=await cloudStorage.createNewNote(userId: userId,userText: text);
   
    _notes.add(newNotes);
    notifyListeners();
    return newNotes;
   }

  Stream<Iterable<CloudNote>>fetchNotes(){
    final userId=FirebaseAuth.instance.currentUser!.uid;
    final fetchedNote=cloudStorage.getAllNotes(userId: userId);
     notifyListeners();
     return fetchedNote;
  }

  Future<void>deleteNote({required String documentId})async{
    await cloudStorage.deleteNote(documentId: documentId);
     
    notifyListeners();
  }

  Future<int>lengthOfNote({required String userId})async{
    final lengtH=await cloudStorage.notesLength(userId: userId);
    notifyListeners();
    return lengtH;
    
  }

 

}


enum MenUActions { delete }


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
    return Scaffold(
      appBar: AppBar(
        title: const Text('TODO'),
        centerTitle: true,
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
      body: Padding(
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
                  child: Consumer<PersonalNoteProvider>(
                    builder: (context, value, child) {
                    return GestureDetector(
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
                        
                        style: TextStyle(fontSize: 23),
                      ),
                    );  
                    },
                    
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(6, 10, 0, 0),
                  child: const Text('Looks like feel good'),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(6, 3, 0, 0),
                  child: const Text('You have 3 tasks to do today'),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.fromLTRB(6, 10, 0, 0),
                  child: Text('TODAY: $currentDate'),
                ),
                SizedBox(height: 60),
                CarouselSlider(
                  
                  items: [
                    Container(
                      color: Colors.red,
                      height: 400,
                    ),  
                    Container(
                      color: Colors.black,
                      height: 400,
                    ),  
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed("/personalView");
                      },
                      child: Container(
                        height: 400,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: const Color.fromARGB(255, 251, 235, 235),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white30,
                              offset: const Offset(5.0, 5.0),
                              blurRadius: 14.0,
                              spreadRadius: 3.0,
                            ),
                          ],
                        ),
                      
                        child: Container(
                          // width: double.infinity,
                          // color: Colors.red,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CircleAvatar(
                                      child: Icon(
                                        Icons.person,
                                        color: Colors.deepOrange,
                                      ),
                                    ),
                                    PopupMenuButton(
                                      onSelected: (value) {
                                       
                                      },
                                      itemBuilder: (context) {
                                        return [
                                          PopupMenuItem<MenUActions>(
                                            value: MenUActions.delete,
                                            child: const Text('Delete'),
                                          ),
                                        ];
                                      },
                                    ),
                                  ],
                                ),
                      
                                SizedBox(
                                  height: 100,
                                  width: double.infinity,
                                  // color: Colors.yellow,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        '9 Tasks',
                                        style: TextStyle(fontSize: 9),
                                      ),
                                      const Text(
                                        'Personal',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      Slider(
                                        value: 0.7,
                                        onChanged: (value) {
                                          setState(() {});
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
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
    );
  }
}


// class MyApiTesting extends StatefulWidget {
//   const MyApiTesting({super.key});

//   @override
//   State<MyApiTesting> createState() => _MyApiTestingState();
// }

// class _MyApiTestingState extends State<MyApiTesting> {
//   late final TextEditingController _email;
//   late final TextEditingController _password;
//   late final TextEditingController _password2;
  
//   List<dynamic> _data = [];

//   apitest() async {
//     var url = Uri.parse('http://192.168.0.106:8000/products/');
//     var response = await http.get(url);
//     if (response.statusCode == 200) {
//       var jsonResponse = convert.jsonDecode(response.body);
 
//       setState(() {
//         _data = jsonResponse;
//       });
//     }else{
//       setState(() {
//         _data = [{'name': 'Error', 'price': response.statusCode}];
//       });
//     }
//   }

//   apiPost()async{
//     final url=Uri.parse('http://192.168.0.106:8000/users/register/');
//     final headers={'Content-Type':'application/json'};
//     final body=convert.jsonEncode({
//       'email':_email.text,
//       "password":_password.text,
//       "password2":_password2.text
//     });
//     final response= await http.post(url, headers: headers,body: body);

//     if(response.statusCode==200){
//       print('data is posting....');
//       print(response.body);
//     }else{
//       print('ERROR: ${response.statusCode}');
//     }
//   }

//   @override
//   void initState() {
//     _email=TextEditingController();
//     _password=TextEditingController();
//     _password2=TextEditingController();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _email.dispose();
//     _password.dispose();
//     _password2.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Simple Api testing')),
//       body: Column(
//         children: [
          
//           TextField(
//             controller: _email,
//             decoration: InputDecoration(
//               hintText: 'Email'
//             ),
//           ),
//           TextField(
//             controller: _password,
//               decoration: InputDecoration(
//               hintText: 'Password'
//             ),
//           ),
//           TextField(
//             controller: _password2,
//              decoration: InputDecoration(
//               hintText: 'Confirm Password'
//             ),
//           ),

//           ElevatedButton(onPressed:apiPost, child: const Text('Post data')),
          
//           // Expanded(
//           //   child: ListView.builder(
//           //     itemCount: _data.length,
//           //     itemBuilder: (context, index) {
//           //       final item = _data[index];
//           //       return ListTile(
//           //         leading: Icon(item['icon_url']),
//           //         title: Text(item['title']
                  
//           //         ),
//           //       );
//           //     },
//           //   ),
//           // ),
      

//         ],
//       ),
//     );
//   }
// }