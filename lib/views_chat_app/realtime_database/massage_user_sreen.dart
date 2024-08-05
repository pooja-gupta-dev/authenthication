import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';

import 'chat_screen.dart';

class MassageUserSreen extends StatefulWidget {
  const MassageUserSreen({super.key});

  @override
  State<MassageUserSreen> createState() => _MassageUserSreenState();
}

class _MassageUserSreenState extends State<MassageUserSreen> {
  var deviceId ="";
  TextEditingController nameController = TextEditingController();
  @override
  void initState(){
    _getId();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("User Details"),
        ),
        body: Column(
          children: [
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(hintText:"Enter your name"),
            ),
            SizedBox(
              height: 10,),

            Text("Device Id :$deviceId"),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => ChatScreen(
                              userName: nameController.text,
                              deviceId: deviceId)));
                },
                child: const Text("add name"))
          ],
        )
    );
  }
  Future<String?> _getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      deviceId = androidDeviceInfo.id;
      setState(() {});
    }
    return null;
  }
}
