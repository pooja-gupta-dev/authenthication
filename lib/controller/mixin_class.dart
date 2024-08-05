// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// mixin FireServiceSharedPref{
//   // Method to fetch parent data
//   Stream<QuerySnapshot> getData() {
//     return FirebaseFirestore.instance.collection('parents').snapshots();
//   }
//
//   // Method to fetch child data based on parentId
//   Stream<QuerySnapshot> getChildData(String parentId) {
//     return FirebaseFirestore.instance
//         .collection('children')
//         .where('parentId', isEqualTo: parentId)
//         .snapshots();
//   }
//
//   // Widget to build parent card
//   Widget buildParentCard(Map<String, dynamic> parentData, String parentId) {
//     return Card(
//       margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//       child: Padding(
//         padding: const EdgeInsets.all(15.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "Name: ${parentData['name'] ?? ""}",
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             Text("Email: ${parentData['email'] ?? ""}"),
//             Text("Phone: ${parentData['phone'] ?? ""}"),
//             Text("Gender: ${parentData['gender'] ?? ""}"),
//             SizedBox(height: 10),
//             // Adds space between parent and child data
//             buildChildList(parentId),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // Widget to build child list
//   Widget buildChildList(String parentId) {
//     return StreamBuilder(
//       stream: getChildData(parentId),
//       builder: (context, childSnapshot) {
//         if (childSnapshot.connectionState == ConnectionState.waiting) {
//           return CircularProgressIndicator();
//         }
//         if (childSnapshot.hasError) {
//           return Text("Error: ${childSnapshot.error}");
//         }
//         if (!childSnapshot.hasData || childSnapshot.data!.docs.isEmpty) {
//           return Text("No child data available");
//         }
//
//         var childData = childSnapshot.data!.docs.toList();
//         return ListView.builder(
//           shrinkWrap: true,
//           physics: NeverScrollableScrollPhysics(),
//           itemCount: childData.length,
//           itemBuilder: (context, index) {
//             var child = childData[index].data() as Map<String, dynamic>;
//             return Card(
//               color: Colors.white,
//               elevation: 20,
//               margin: EdgeInsets.symmetric(vertical: 5),
//               child: Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Child Name: ${child['childname'] ?? ""}",
//                       style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                     ),
//                     Text("Child Email: ${child['childemail'] ?? ""}"),
//                     Text("Child Phone: ${child['childphone'] ?? ""}"),
//                     Text("Child Gender: ${child['childgender'] ?? ""}"),
//                   ],
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }
import 'package:flutter/material.dart';

mixin class CustumWidgets{
  viewTextFild(String name,TextEditingController controller,[IconData? icon,String? level]){
    return Padding(padding: EdgeInsets.all(8.0),
        child: TextField(
          controller:controller ,
          decoration: InputDecoration(

              prefixIcon:Icon(icon),
              hintText: name,
              labelText:level ,
              border: OutlineInputBorder(

                borderRadius: BorderRadius.all(Radius.circular(20)),
              )
          ),
        )
    );

  }
  viewbutton(String name,{required void Function()? onPressed}){
    return MaterialButton(
        height: 50,
        minWidth: 340,
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.white)
        ),
        color:  Color(0xff90873092),
        onPressed: onPressed, child: Text(name,style:
    TextStyle(fontWeight: FontWeight.bold,color: Colors.white),));
  }
}
