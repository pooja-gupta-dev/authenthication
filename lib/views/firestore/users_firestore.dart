import 'package:cloud_firestore/cloud_firestore.dart';

class UsersFireStore {
  final CollectionReference _collection = FirebaseFirestore.instance.collection('users_data');

  Future<void> addUsersData(String name, String age, String email, String phone, String vill ,String pinCode ,String post) async {
    await _collection.add({
      'name': name,
      'age': age,
      'email': email,
      'phone': phone,

      "address":{
        "vill": vill,
        "pinCode": pinCode,
        "post":post
      }

    });
  }

  Stream<List<Map<String, dynamic>>> getUsersData() {
    // return _collection.where('age',isEqualTo: 19).snapshots().map((querySnapshot) {

    return _collection.orderBy("name").snapshots().map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;
        return data;
      }).toList();
    });
  }

  Future<void> deleteUsersData(String docId) async {
    await _collection.doc(docId).delete();
  }
}