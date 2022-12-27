import 'package:cloud_firestore/cloud_firestore.dart';


void insertData(String note) {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  CollectionReference collectionReference = firebaseFirestore.collection(
      "KeepNote");

  collectionReference.add(
      {"note": "$note","check":false}).then((


      value) => print("Success")).catchError((errore) =>
      print("Errore $errore"));
}

Stream<QuerySnapshot<Map<String, dynamic>>> readData(){
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  return firebaseFirestore.collection("KeepNote").snapshots();
}

void deleteData(String key){
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  firebaseFirestore.collection("KeepNote").doc("$key").delete();
}

void updateData(String key, String note,bool check){
  print("========================= $note");
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  firebaseFirestore.collection("KeepNote").doc("$key").set({"note":"$note","check":check});
}