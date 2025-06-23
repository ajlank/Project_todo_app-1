import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/enums/menu_item.dart';
import 'package:todoapp/statemanagement/personal_note_provider.dart';
import 'package:todoapp/utils/constants.dart';
import 'package:todoapp/views/personal_view.dart';

class SliderItem1 extends StatelessWidget {
  const SliderItem1({super.key});

  @override
  Widget build(BuildContext context) {
   double valuE = 50;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(personalViewRoute);
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      child: Icon(Icons.person),
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
                     FutureBuilder(
                     future: context.read<PersonalNoteProvider>().lengthOfNote(userId: userId), 
                     builder: (context, snapshot) {
                       if(snapshot.connectionState==ConnectionState.waiting){
                         return Text('Loadig...', style: TextStyle(fontSize: 9));
                       }else if(snapshot.hasError){
                         return Text('Error', style: TextStyle(fontSize: 9));
                       }else{
                        final count=snapshot.data??0;
                        return Text('$count Tasks', style: TextStyle(fontSize: 9));
                       }
                     },),
                      const Text('Personal', style: TextStyle(fontSize: 15)),
                       SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              thumbShape: SliderComponentShape.noThumb,
                            ),
                            child: Slider(
                              value: valuE,
                              
                              onChanged: (value) {
                             
                              },

                              thumbColor: Colors.blue,

                              activeColor: Colors.blue,
                              min: 0,
                              max: 100,
                              divisions: 10,
                            ),
                            
                          ),
                          
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}