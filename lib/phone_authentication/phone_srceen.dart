import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'otp_verification.dart';
class PhoneSrceen extends StatefulWidget {
  @override
  _PhoneSrceenState createState() => _PhoneSrceenState();
}

class _PhoneSrceenState extends State<PhoneSrceen> {
  var phoneController = TextEditingController();
  String verificationId = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.teal,
        title: Text("Phone Authentication"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: "Enter your phone number",
                prefixIcon: Icon(Icons.phone),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
              controller: phoneController,
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                String phoneNumber = "+91${phoneController.text.trim()}";
                try {
                  await FirebaseAuth.instance.verifyPhoneNumber(
                    phoneNumber: phoneNumber,
                    verificationCompleted: (PhoneAuthCredential credential) {

                    },
                    verificationFailed: (FirebaseAuthException e) {
                      print("Verification Failed: ${e.message}");
                      ScaffoldMessenger.of(context).showSnackBar(
                         SnackBar(
                          content: Text("Verification Failed. Please try again."),
                        ),
                      );
                    },
                    codeSent: (String verificationId, int? resendToken) {
                      setState(() {
                        this.verificationId = verificationId;
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OtpVerification (verificationId: verificationId),
                        ),
                      );
                    },
                    codeAutoRetrievalTimeout: (String verificationId) {

                       },
                  );
                } catch (e) {
                  print(" massge");
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Failed to verify phone number. Please try again.",style: TextStyle(color: Colors.red),),
                    ),
                  );
                }
              },
              child: Text("Send OTP"),
            ),
          ],
        ),
      ),
    );
  }
}
