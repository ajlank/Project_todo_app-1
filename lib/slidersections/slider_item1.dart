import 'package:flutter/material.dart';
import 'package:todoapp/enums/menu_item.dart';

class SliderItem1 extends StatelessWidget {
  const SliderItem1({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      child: Icon(Icons.person, color: Colors.deepOrange),
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
                      const Text('9 Tasks', style: TextStyle(fontSize: 9)),
                      const Text('Personal', style: TextStyle(fontSize: 15)),
                      Slider(
                        value: 0.7,
                        onChanged: (value) {
                          
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
    );
  }
}