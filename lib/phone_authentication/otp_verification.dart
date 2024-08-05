import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class OtpVerification extends StatefulWidget {
  final String verificationId;

  OtpVerification({Key? key, required this.verificationId}) : super(key: key);

  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  var otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: Text("OTP Verification"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: const InputDecoration(
                hintText: "Enter OTP",
                prefixIcon: Icon(Icons.lock),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
              controller: otpController,
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                String smsCode = otpController.text.trim();
                try {
                  PhoneAuthProvider.credential(
                    verificationId: widget.verificationId,
                    smsCode: smsCode,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(

                    const SnackBar(
                      content: Text("OTP Verified successfully",style: TextStyle(color: Colors.green),),
                    ),
                  );
                } catch (e) {
                  print("Failed to verify OTP: $e",);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Failed to verify OTP. Please try again."),
                    ),
                  );
                }
              },
              child: Text("Verify OTP"),
            ),
          ],
        ),
      ),
    );
  }
}