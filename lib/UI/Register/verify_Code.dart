import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:otp_input_editor/otp_input_editor.dart';

import '../../Utils/Utils.dart';
import '../s1.dart';

class Verify_code extends StatefulWidget {
  final String verificationId;

  const Verify_code({super.key, required this.verificationId});

  @override
  State<Verify_code> createState() => _Verify_codeState();
}

class _Verify_codeState extends State<Verify_code> {
  bool loading = false;

  final verificationCodeController = TextEditingController();
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white12,
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Center(
          child: Text('Verify'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0),
        child: Container(
            padding: EdgeInsets.all(29.w),
            height: 343.h,
            width: double.infinity.w,
            color: Colors.greenAccent[900],
            child: Column(
              children: [
                SizedBox(
                  height: 30.h,
                ),
                const OtpInputEditor(
                  otpLength: 6,
                  obscureText: false,
                ),
                TextFormField(
                  style: const TextStyle(fontSize: 24),
                  keyboardType: TextInputType.phone,
                  controller: verificationCodeController,
                  maxLength: 6,
                  decoration: const InputDecoration(
                    hintText: '6 digit code',
                    hintStyle: TextStyle(color: Colors.black),
                  ),
                ),
                SizedBox(
                  height: 50.h,
                ),
                TextButton(
                    child: const Text('Verify'),
                    onPressed: () async {
                      setState(() {
                        loading = true;
                      });

                      final credential = PhoneAuthProvider.credential(
                          verificationId: widget.verificationId,
                          smsCode: verificationCodeController.text.toString());

                      try {
                        await auth.signInWithCredential(credential);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const S1()));
                      } catch (e) {
                        setState(() {
                          loading = false;
                        });
                        Utils().toastMessage(e.toString());
                      }
                    })
              ],
            )),
      ),
    );
  }
}
