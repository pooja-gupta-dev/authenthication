import 'package:cloud_firestore/cloud_firestore.dart';

Future<String> parentData(
    String name, String email, int phone, String gender) async {
  var doc =
  await FirebaseFirestore.instance.collection("parentsAddData").add({
    "name": name,
    "email": email,
    "phone": phone,
    "gender": gender,
  });
  return doc.id;
}

Stream<QuerySnapshot<Map<String, dynamic>>> getData() {
  var inatance = FirebaseFirestore.instance;
  var data = inatance.collection("parentsAddData").snapshots();
  return data;
}

childtData(String name, String email, int phone, String gender,
    String parentId) async {
  FirebaseFirestore.instance.collection("childrenData").add({
    "childname": name,
    "childemail": email,
    "childphone": phone,
    "childgender": gender,
    "chilsprentid": parentId,
  });
}

Stream<QuerySnapshot<Map<String, dynamic>>> getChildData(String parentId) {
  var inatance = FirebaseFirestore.instance;
  var data = inatance
      .collection("childrenData")
      .where("chilsprentid", isEqualTo: parentId)
      .snapshots();
  return data;
}
