import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final String deviceId;
  final String userName;
  const ChatScreen({super.key,required this.deviceId,required this.userName});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  var uesrId="";
  var delete="";
  TextEditingController messageController=TextEditingController();
  var chatRef = FirebaseDatabase.instance.ref("chat");



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat Screen"),

        backgroundColor: Colors.blueGrey,
      ),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
                children: [
            Expanded(
            child: StreamBuilder(
            stream: getMassage(),
            builder: (_, snap) {
              if (snap.hasData) {
                var data = snap.data?.snapshot.children.toList();
                return data?.isNotEmpty != null
                    ? ListView.builder(
                  itemCount: data!.length,
                  itemBuilder: (_, index) {
                    var message = data[index].value as Map;
                    var senderId = message['senderId'].toString();
                    return senderId == widget.deviceId
                        ? Align(
                      alignment: Alignment.bottomRight,
                      child: getmassgeView(message),
                    )
                        : Align(
                      alignment: Alignment.bottomLeft,
                      child:getmassgeView(message),
                    );
                  },

                )
                    : const Center(
                  child: Text("No message found!"),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }
            ),
       ),
                  Row(
                    children: [
                      Expanded(child: TextFormField(
                        decoration: InputDecoration(
                      hintText: "Type message....",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color:Colors.black12,
                        )
                      ),
                          focusedBorder: OutlineInputBorder(
                             borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(color:Colors.black12
                          )
                        ),
                        enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.black))),
                         controller: messageController,
                        ),
                          ),
                           SizedBox(width: 5,),
                      CircleAvatar(
                          radius: 30,
                          child: IconButton(
                            onPressed: () {
                              addMassage(messageController.text.trim());
                            },
                            icon: Icon(
                              Icons.send,
                              size: 20,
                            ),
                      )
                      ),

                    ],
                  ),
                  SizedBox(
                  height: 20,),
             ],
            ),

    ),

    );
  }




 Widget getmassgeView(Map<dynamic,dynamic>massage){
    return InkWell(
      onLongPress: ()=> deletMassge(massage['id']),
      child: Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(massage['name'],style: TextStyle(fontWeight: FontWeight.bold),
      ),
        Text(massage['massage'].toString()),
        Text(
      massage['date'].toString(),
        style: TextStyle(fontSize: 10),
      ),
        ],
        ),
        ),
    );
  }
  addMassage(String massge)async{
    var id=chatRef.push().key;
    await chatRef.child(id.toString()).set({
    'id':id.toString(),
  "name": widget.userName,
  "massage":massge,
  'senderId': widget.deviceId,
  "date": DateTime.now().toString()
  }).then((value) {
  messageController.clear();
  });
  }
  Stream<DatabaseEvent> getMassage() {
  return chatRef.onValue;
  }
   deletMassge(String massgeId)async{
    await chatRef.child(massgeId).remove();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("massage delete successfull",style: TextStyle(fontSize: 20),),
        backgroundColor: Colors.blue,

      )
    );
   }
}
