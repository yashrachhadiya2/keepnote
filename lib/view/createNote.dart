import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keepnote/controller/homeController.dart';
import 'package:keepnote/modal/firebase.dart';

class CreateNote extends StatefulWidget {
  const CreateNote({Key? key}) : super(key: key);

  @override
  State<CreateNote> createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> {
HomeController homeController =Get.put(HomeController(),);

  TextEditingController txtnote = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        centerTitle: true,
        title: Text("Create Note",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            TextField(
              controller: txtnote,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.greenAccent,width: 2),
                ),

                hintText: 'Write Note',
                prefixIcon: Icon(Icons.note,color: Colors.greenAccent,),
              ),
            ),
            SizedBox(height: 40,),
            Row(
              mainAxisAlignment:MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 50,
                  child: ElevatedButton(onPressed: (){
                  },
                    child: Text("Cancle",style: TextStyle(
                      fontSize: 25,
                    ),),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.greenAccent,),),
                ),

                SizedBox(
                  height: 50,
                  child: ElevatedButton(onPressed: (){
                       insertData(txtnote.text);
                       homeController.checked.add(false);

                       Get.back();
                  },
                    child: Text("Create",style: TextStyle(
                      fontSize: 25,
                    ),),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.greenAccent,),),
                ),              ],
            ),
          ],
        ),
      ),
    ),);
  }
}
