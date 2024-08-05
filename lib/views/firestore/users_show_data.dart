import 'package:authenthication/views/firestore/upses_update_screen.dart';
import 'package:flutter/material.dart';

import 'users_firestore.dart';

class UsersShowData extends StatefulWidget {
  const UsersShowData({super.key});

  @override
  State<UsersShowData> createState() => _UsersShowDataState();
}

class _UsersShowDataState extends State<UsersShowData> {
  final UsersFireStore _firestoreService = UsersFireStore();

  void _deleteItem(String docId) async {
    await _firestoreService.deleteUsersData(docId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.orangeAccent,
        title: const Text(
          "Users Show Data",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: _firestoreService.getUsersData(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          var data = snapshot.data!;

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              var userData = data[index];
              var addressData = userData['address'] as Map<String, dynamic>?;

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  color: Colors.white,
                  shadowColor: Colors.orangeAccent,
                  elevation: 3,
                  child: ListTile(
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          userData['name'] ?? 'No name',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Text(userData['email'] ?? 'No email'),
                        Text(userData['phone']?.toString() ?? 'No phone'),
                        Text(userData['age']?.toString() ?? 'No age'),

                        Text("Address", style: TextStyle(fontSize: 20, color: Colors.orangeAccent, fontWeight: FontWeight.w900)),

                        Text(addressData?['vill'] ?? 'No village'),
                        Text(addressData?['post'] ?? 'No post'),
                        Text(addressData?['pinCode']?.toString() ?? 'No pinCode'),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.purpleAccent),
                          onPressed: () async {
                            bool? result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UsersUpdateScreen(
                                  docId: userData['id'],
                                  name: userData['name'],
                                  email: userData['email'],
                                  phone: int.tryParse(userData['phone'].toString()) ?? 0,
                                  age: int.tryParse(userData['age'].toString()) ?? 0,
                                  vill: addressData?['vill'],
                                  pinCode: int.tryParse(addressData?['pinCode']?.toString() ?? '0') ?? 0,
                                  post: addressData?['post'],
                                ),
                              ),
                            );

                            if (result == true) {
                              setState(() {}); // Trigger a rebuild to refresh the data
                            }
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.orangeAccent),
                          onPressed: () {
                            _deleteItem(userData['id']);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

}