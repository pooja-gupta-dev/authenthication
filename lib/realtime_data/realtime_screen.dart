// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
//
// class RealtimeScreen extends StatefulWidget {
//   const RealtimeScreen({super.key});
//
//   @override
//   State<RealtimeScreen> createState() => _RealtimeScreenState();
// }
//
// class _RealtimeScreenState extends State<RealtimeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("REARLTIME DATABASE SCREEN",style: TextStyle(color: Colors.purpleAccent),),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(onPressed:(){
//               realTime();
//             }, child: const Text("data",style: TextStyle(backgroundColor: Colors.black),)),
//           ],
//         ),
//       ),
//     );
//   }
//   realTime(){
//  FirebaseDatabase.instance.ref('ures data').child('first').set({
//    "name":"Pooja",
//     "email": "pg@gmail.com",
//    "address": {
//      "village": "Agauthar sundar",
//      "post": "Agauthar nanda",
//      "state": "crp",
//      "police station":"Isuaapur",
//      "pin code": 841411
//    }
//  });
// }
// }
//
//
// // import 'package:firebase_database/firebase_database.dart';
// // import 'package:flutter/material.dart';
// //
// // class RealtimeScreen extends StatefulWidget {
// //   const RealtimeScreen({super.key});
// //
// //   @override
// //   State<RealtimeScreen> createState() => _RealtimeScreenState();
// // }
// //
// // class _RealtimeScreenState extends State<RealtimeScreen> {
// //   final _databaseReference = FirebaseDatabase.instance.ref();
// //   String _statusMessage = '';
// //   bool? _isMale;
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text(
// //           "REALTIME DATABASE ",
// //           style: TextStyle(color: Colors.purpleAccent),
// //         ),
// //       ),
// //       body: Center(
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             Row(
// //               mainAxisAlignment: MainAxisAlignment.center,
// //               children: [
// //                 ElevatedButton(
// //                   onPressed: () {
// //                     setState(() {
// //                       _isMale = true;
// //                     });
// //                   },
// //                   child: const Text("Male"),
// //                   style: ElevatedButton.styleFrom(
// //                     backgroundColor: _isMale == true ? Colors.blue : Colors.grey,
// //                   ),
// //                 ),
// //                 const SizedBox(width: 10),
// //                 ElevatedButton(
// //                   onPressed: () {
// //                     setState(() {
// //                       _isMale = false;
// //                     });
// //                   },
// //                   child: const Text("Female"),
// //                   style: ElevatedButton.styleFrom(
// //                     backgroundColor: _isMale == false ? Colors.blue : Colors.grey,
// //                   ),
// //                 ),
// //               ],
// //             ),
// //             const SizedBox(height: 20),
// //             ElevatedButton(
// //               onPressed: _isMale != null ? realTime : null,
// //               child: const Text(
// //                 "Add",
// //                 style: TextStyle(color: Colors.white),
// //               ),
// //             ),
// //             const SizedBox(height: 20),
// //             Text(
// //               _statusMessage,
// //               style: const TextStyle(color: Colors.black, fontSize: 16),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// //
// //   void realTime() {
// //     _databaseReference.child('users_data').child('users').set({
// //       "name": "Pooja",
// //       "email": "pg@gmail.com",
// //       "gender": _isMale,
// //       "address": {
// //         "village": "Agauthar Sundar",
// //         "post": "Agauthar Nanda",
// //         "state": "CRP",
// //         "police_station": "Isuaapur",
// //         "pin_code": 841411,
// //       }
// //     }).then((_) {
// //       setState(() {
// //         _statusMessage = "Data has been written successfully!";
// //       });
// //     }).catchError((error) {
// //       setState(() {
// //         _statusMessage = "Failed to write data: $error";
// //       });
// //     });
// //   }
// // }
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class RealtimeScreen extends StatefulWidget {
  const RealtimeScreen({super.key});

  @override
  State<RealtimeScreen> createState() => _RealtimeScreenState();
}

class _RealtimeScreenState extends State<RealtimeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Center(child: Text("Real Time Data Base",style: TextStyle(color: Colors.white),)),
      ),
      body: Column(
        children: [
          SizedBox(height: 20,),
          ElevatedButton(
              onPressed: (){
                realTimeDatabase();
              }, child: Padding(
            padding: const EdgeInsets.only(right: 20,left: 30),

            child: Text("Add"),
          )),
          ElevatedButton(onPressed: (){
            realTimeDatabase();
          }, child: Padding(
            padding: const EdgeInsets.only(right: 20,left: 30),
            child: Text("Add"),)

          ),

        ],
      ),
    );

  }
  realTimeDatabase()async{
    var  realTime = await
    FirebaseDatabase.instance.ref("users").child("first");
    realTime.set({
      "name": "Pooja Gupta",
      "email": "pg@gmail.com",
      "phone": 25478846353
    });

    await realTime.child("Address").set({
      "village": "Agauthar Sundar",
      "post": "Agauthar Nanda",
      "state": "CRP",
         "police_station": "Isuaapur",
         "pin_code": 841411,
    });
    await realTime.child("gender").set({
      "male": "True",
      "fimale": "false",
    });

  }
 }