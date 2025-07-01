// import 'dart:convert' as convert;
import 'package:get_storage/get_storage.dart';
import 'package:todoapp/mainapps/root_app.dart';
import 'package:todoapp/statemanagement/family_task_note_provider.dart';
import 'package:todoapp/statemanagement/personal_note_provider.dart';
import 'package:todoapp/statemanagement/theme_provider.dart';
import 'package:todoapp/statemanagement/work_note_provider.dart';
import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
        create: (context) =>PersonalNoteProvider()
        ),
        ChangeNotifierProvider(
        create: (context) =>ThemeProvider()
        ),
        ChangeNotifierProvider(
          create:(context) => WorkNoteProvider(), 
        ),
        ChangeNotifierProvider(
          create:(context) =>FamilyTaskNoteProvider(),
        )
      ],
     child: RootAPP(),
    )
   
  );
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