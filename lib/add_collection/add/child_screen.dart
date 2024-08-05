import 'package:flutter/material.dart';

import '../../controller/parent_service.dart';
import 'child_list_screen.dart';

class ChildScreen extends StatefulWidget {
  final parentId;
  const ChildScreen({super.key, this.parentId});

  @override
  State<ChildScreen> createState() => _ChildScreenState();
}

class _ChildScreenState extends State<ChildScreen> {
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
              builder: (context) => ChildListScreen(
                parentId: widget.parentId,
              ),
            ),
          );
        },
        child: const Text("Add"),
      ),
      appBar: AppBar(
        backgroundColor: const Color(0xff90873092),
        centerTitle: true,
        title: const Text(
          "child Data",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: StreamBuilder(
            stream: service().getChildData(widget.parentId),
            builder: (context, snapshot) {
              var data = snapshot.data?.docs.toList();
              return ListView.builder(
                itemCount: data?.length,
                itemBuilder: (context, index) {
                  var parentData = data?[index].data();
                  return Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("name:-${parentData?['childname'] ?? ""}"),
                        Text("email:-${parentData?['childemail'] ?? ""}"),
                        Text("phone:-${parentData?['childphone'] ?? ""}"),
                        Text("gender:-${parentData?['chlidgender'] ?? ""}"),
                      ],
                    ),
                  );
                },
              );
            }),
      ),
    );
  }
}
