import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/views/personal_view.dart';
import 'package:todoapp/writingView/write_personal.dart';
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) =>PersonalNoteProvider(),
     child: RootAPP(),
    )
   
  );
}

class RootAPP extends StatelessWidget {
  const RootAPP({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 255, 171, 16),
        ),
      ),
      home: MyApp(),
      routes: {
        '/personalView': (context) => PersonalView(),
         '/writePersonal':(context)=> WritePersonal()
        },
    );
  }
}

class Item{

  final String text;

  const Item({required this.text});
  
  @override
  String toString() {
    return 'user note $text';
  }
}
class PersonalNoteProvider extends ChangeNotifier{
   
   final List<Item> _notes=[];
  
  UnmodifiableListView<Item> get items => UnmodifiableListView(_notes);
  
  void add(Item item) {
    _notes.add(item);
    notifyListeners();
  }


  void removeAll() {
    _notes.clear();
    notifyListeners();
  }
  List<Item> get notes=>_notes;
  
  
}


enum MenUActions { delete }


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DateTime get times => DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TODO'),
        centerTitle: true,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
      ),
      drawer: Drawer(),
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
                  child: const Text(
                    'Hello, Jane',
                    style: TextStyle(fontSize: 23),
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
                  child: Text('TODAY: $times'),
                ),
                SizedBox(height: 60),
                CarouselSlider(
                  items: [
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
                                      onSelected: (value) {},
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

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Simple Api testing')),
//       body: Column(
//         children: [
//           ElevatedButton(onPressed: apitest, child: const Text('Get data')),
//           Expanded(
//             child: ListView.builder(
//               itemCount: _data.length,
//               itemBuilder: (context, index) {
//                 final item = _data[index];
//                 return ListTile(
//                   leading: Icon(item['icon_url']),
//                   title: Text(item['title']
                  
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

