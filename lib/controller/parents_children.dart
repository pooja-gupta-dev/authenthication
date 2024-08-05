// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
//
// import 'mixin_class.dart';
//  // import '../../controller/fire_service_sharedfrif.dart';
//
// class GetdataParentsChildren extends StatefulWidget {
//   const GetdataParentsChildren({super.key});
//
//   @override
//   State<GetdataParentsChildren> createState() => _GetdataParentsChildrenState();
// }
//
// class _GetdataParentsChildrenState extends State<GetdataParentsChildren> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.green,
//         centerTitle: true,
//         title: Text(
//           "GetData Child and parents",
//           style: TextStyle(color: Colors.white),
//         ),
//       ),
//       body: Center(
//         child: StreamBuilder(
//            stream: FireServiceSharedPref().getData(),
//           builder: (context, snapshot) {
//
//             var data = snapshot.data!.docs.toList();
//
//             return ListView.builder(
//               itemCount: data.length,
//               itemBuilder: (context, index) {
//                 var parentData = data[index].data() as Map<String, dynamic>;
//                 var parentId = data[index].id;
//
//                 return Card(
//                   margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//                   child: Padding(
//                     padding: const EdgeInsets.all(15.0),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "Name: ${parentData['name'] ?? ""}",
//                           style: TextStyle(
//                               fontSize: 20, fontWeight: FontWeight.bold),
//                         ),
//                         Text("Email: ${parentData['email'] ?? ""}"),
//                         Text("Phone: ${parentData['phone'] ?? ""}"),
//                         Text("Gender: ${parentData['gender'] ?? ""}"),
//                         SizedBox(height: 10),
//                         // Adds space between parent and child data
//
//                         StreamBuilder(
//                           stream:
//                           FireServiceSharedPref().getChildData(parentId),
//                           builder: (context, childSnapshot) {
//                             var childData = childSnapshot.data!.docs.toList();
//                             return ListView.builder(
//                               shrinkWrap: true,
//                               physics: NeverScrollableScrollPhysics(),
//                               itemCount: childData.length,
//                               itemBuilder: (context, index) {
//                                 var child = childData[index].data()
//                                 as Map<String, dynamic>;
//                                 return Card(
//                                   color: Colors.white,
//                                   elevation: 20,
//                                   margin: EdgeInsets.symmetric(vertical: 5),
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(10.0),
//                                     child: Column(
//                                       mainAxisAlignment:
//                                       MainAxisAlignment.start,
//                                       crossAxisAlignment:
//                                       CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           "Child Name: ${child['childname'] ?? ""}",
//                                           style: TextStyle(
//                                               fontSize: 18,
//                                               fontWeight: FontWeight.bold),
//                                         ),
//                                         Text(
//                                             "Child Email: ${child['childemail'] ?? ""}"),
//                                         Text(
//                                             "Child Phone: ${child['childphone'] ?? ""}"),
//                                         Text(
//                                             "Child Gender: ${child['childgender'] ?? ""}"),
//                                       ],
//                                     ),
//                                   ),
//                                 );
//                               },
//                             );
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
//
//
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetdataParentsChildren extends StatefulWidget {
  const GetdataParentsChildren({Key? key}) : super(key: key);

  @override
  State<GetdataParentsChildren> createState() => _GetdataParentsChildrenState();
}

class _GetdataParentsChildrenState extends State<GetdataParentsChildren> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        title: Text(
          "GetData Child and parents",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: StreamBuilder<QuerySnapshot>(
          stream: _firestore.collection('parents').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }

            var data = snapshot.data!.docs.toList();

            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                var parentData = data[index].data() as Map<String, dynamic>;
                var parentId = data[index].id;

                return Card(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Name: ${parentData['name'] ?? ""}",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text("Email: ${parentData['email'] ?? ""}"),
                        Text("Phone: ${parentData['phone'] ?? ""}"),
                        Text("Gender: ${parentData['gender'] ?? ""}"),
                        SizedBox(height: 10),
                        // Adds space between parent and child data

                        StreamBuilder<QuerySnapshot>(
                          stream: _firestore
                              .collection('children')
                              .where('parentId', isEqualTo: parentId)
                              .snapshots(),
                          builder: (context, childSnapshot) {
                            if (!childSnapshot.hasData) {
                              return SizedBox();
                            }

                            var childData =
                            childSnapshot.data!.docs.toList();

                            return ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: childData.length,
                              itemBuilder: (context, index) {
                                var child =
                                childData[index].data() as Map<String, dynamic>;
                                return Card(
                                  color: Colors.white,
                                  elevation: 20,
                                  margin: EdgeInsets.symmetric(vertical: 5),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Child Name: ${child['childname'] ?? ""}",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          "Child Email: ${child['childemail'] ?? ""}",
                                        ),
                                        Text(
                                          "Child Phone: ${child['childphone'] ?? ""}",
                                        ),
                                        Text(
                                          "Child Gender: ${child['childgender'] ?? ""}",
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

