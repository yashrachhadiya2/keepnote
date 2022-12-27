import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keepnote/controller/homeController.dart';
import 'package:keepnote/modal/firebase.dart';
import 'package:keepnote/modal/modalScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController homeController = Get.put(
    HomeController(),
  );




  TextEditingController txtEdiat = TextEditingController();

  TextEditingController Edit = TextEditingController();

  List<ModalData> l1 = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "Sunday,",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "29 Mar",
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),

              Expanded(
                child: StreamBuilder(
                  stream: readData(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    } else if (snapshot.hasData) {
                      l1.clear();
                      List<QueryDocumentSnapshot> list = snapshot.data!.docs;
                      for (var d1 in list) {
                        Map m1 = d1.data() as Map<String, dynamic>;
                        String note = m1['note'];
                        var key = d1.id;
                        bool? check = false;


                        ModalData modaldata = ModalData(
                          note: "$note",
                          key: "$key",
                          check: check,
                        );
                        l1.add(modaldata);
                      }
                      return ListView.builder(
                          itemCount: l1.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                      leading: Checkbox(
                        onChanged: (value){
                          setState(() {
                            homeController.checked[index] = value!;
                          });
                        },
                        value: homeController.checked[index],
                      ),
                              title: Text("${l1[index].note}"),
                              trailing: SizedBox(
                                width: 100,
                                child: Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        Edit = TextEditingController(text: l1[index].note);
                                        Get.defaultDialog(
                                          content: Column(
                                            children: [
                                              TextField(
                                                controller: Edit,
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(),
                                                  ),
                                                  hintText: 'ReNote',
                                                  prefixIcon: Icon(
                                                    Icons.note,
                                                  ),
                                                ),
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  updateData("${l1[index].key}", "${Edit.text}", l1[index].check!);

                                                  Get.back();
                                                },
                                                child: Text(
                                                  "Submit",
                                                  style: TextStyle(
                                                    fontSize: 25,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      icon: Icon(Icons.edit),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        Get.defaultDialog(
                                          content: Column(
                                            children: [
                                              Text("Are you sure exit"),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      deleteData(
                                                          "${l1[index].key}");

                                                      Get.back();
                                                    },
                                                    child: Text(
                                                      "Yes",
                                                      style: TextStyle(
                                                        fontSize: 25,
                                                      ),
                                                    ),
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          Colors.greenAccent,
                                                    ),
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      Get.back();
                                                    },
                                                    child: Text(
                                                      "No",
                                                      style: TextStyle(
                                                        fontSize: 25,
                                                      ),
                                                    ),
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          Colors.redAccent,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      icon: Icon(Icons.delete),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    }
                    return CircularProgressIndicator();
                  },
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.toNamed('/note');
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
