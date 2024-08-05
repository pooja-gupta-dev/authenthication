import 'package:flutter/material.dart';

import '../../controller/parent_service.dart';
import 'add_parent_screen.dart';
import 'child_screen.dart';

class ParentsListScreen extends StatefulWidget {
  const ParentsListScreen({super.key});

  @override
  State<ParentsListScreen> createState() => _ParentsListScreenState();
}

class _ParentsListScreenState extends State<ParentsListScreen> {
  var data = service();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(
            side: BorderSide(
          color: Color(0xff90873092),
        )),
        onPressed: () async {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddParentScreen(),
            ),
          );
        },
        child: const Text("Add"),
      ),
      appBar: AppBar(
        backgroundColor: const Color(0xff90873092),
        centerTitle: true,
        title: const Text(
          "Parent Data",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: StreamBuilder(
            stream: service().getData(),
            builder: (context, snapshot) {
              var data = snapshot.data?.docs.toList();
              return ListView.builder(
                itemCount: data?.length,
                itemBuilder: (context, index) {
                  var parentData = data?[index].data();
                  return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChildScreen(
                                parentId: data![index].id,
                              ),
                            ));
                      },
                      child: Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("name:-${parentData?['name'] ?? ""}"),
                            Text("email:-${parentData?['email'] ?? ""}"),
                            Text("phone:-${parentData?['phone'] ?? ""}"),
                            Text("gender:-${parentData?['gender'] ?? ""}"),
                          ],
                        ),
                      ));
                },
              );
            }),
      ),
    );
  }
}
