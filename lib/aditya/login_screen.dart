import 'package:cancer/home/pre_op/navigation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cancer/aditya/home.dart';
import 'package:cancer/aditya/phone_number_authentication.dart';
import 'package:cancer/aditya/pone_provider.dart';
import 'package:cancer/aditya/role.dart';

import '../doctor/dashboard_screen.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _phoneController = TextEditingController();
  final _otpController = TextEditingController();
  final PhoneAuthService _phoneAuthService = PhoneAuthService();

  String? _verificationId;
  bool _isCodeSent = false;
  bool _isLoading = false;

  // Function to send OTP
  void _sendOTP() async {
    setState(() {
      _isLoading = true;
    });

    String phoneNumber = _phoneController.text.trim();
    Provider.of<PhoneProvider>(context, listen: false)
        .setPhoneNumber(phoneNumber);
        print("AD-"+phoneNumber);

    bool isRegistered = true;//await _phoneAuthService.isPhoneNumberRegistered(phoneNumber);
    
    isRegistered?print("AD-true"):print("AD-true");
    if (isRegistered) {
      await _phoneAuthService.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _phoneAuthService.signInWithSmsCode(
            verificationId: credential.verificationId ?? '',
            smsCode: credential.smsCode ?? '',
          );
          setState(() {
            _isLoading = false;
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          setState(() {
            _isLoading = false;
          });
        },
        codeSent: (String verificationId) {
          setState(() {
            _verificationId = verificationId;
            print("AD-"+verificationId);
            _isCodeSent = true;
            _isLoading = false;
          });
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          _verificationId = verificationId;
        },
      );
    } else {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('This phone number is not registered.')),
      );
    }
  }

  // Function to verify OTP and navigate to the appropriate dashboard
  void _verifyOTP() async {
    setState(() {
      _isLoading = true;
    });

    User? user = await _phoneAuthService.signInWithSmsCode(
      verificationId: _verificationId ?? '',
      smsCode: _otpController.text.trim(),
    );

    setState(() {
      _isLoading = false;
    });

    if (user != null) {
      String phoneNumber = _phoneController.text.trim();
      String? role = await getUserRole(phoneNumber);

      if (role == 'doctor') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DashboardScreen(Provider.of<PhoneProvider>(context, listen: false).phoneNumber)),
        );
      } else if (role == 'patients') {
        DateTime? surgeryDate = await getUserSurgeryDate(phoneNumber);
        if (surgeryDate != null) {
          DateTime currentDate = DateTime.now();
          if (currentDate.isBefore(surgeryDate)) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PreHomePage()),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MainScreen()),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Surgery date not found.')),
          );
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid OTP')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.orange.shade400, Colors.orange.shade600],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(height: 40),
                          // Image above login section
                          Center(
                            child: Image.asset(
                              'assets/images/manipal.png', // Update with your image path
                              height: 150, // Adjust the height as needed
                            ),
                          ),
                          SizedBox(height: 40),
                          Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 40),
                          // Phone Number TextField
                          TextField(
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              labelText: 'Phone Number',
                              hintText: '+91 123 456 7890',
                              floatingLabelBehavior: FloatingLabelBehavior.never, // Hides label when typing
                              labelStyle: TextStyle(color: const Color.fromARGB(255, 248, 169, 21)),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.9),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                              isDense: true, // Ensures content fits within the text field
                            ),
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(height: 20),
                          // OTP TextField (only shown if OTP is sent)
                          if (_isCodeSent)
                            TextField(
                              controller: _otpController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: 'OTP',
                                floatingLabelBehavior: FloatingLabelBehavior.never, // Hides label when typing
                                labelStyle: TextStyle(color: const Color.fromARGB(255, 248, 169, 21)),
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.9),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                                isDense: true, // Ensures content fits within the text field
                              ),
                              style: TextStyle(fontSize: 18),
                            ),
                          SizedBox(height: 40),
                          // Loading Indicator or Login/Verify Button
                          _isLoading
                              ? Center(child: CircularProgressIndicator())
                              : ElevatedButton(
                                  onPressed: _isCodeSent ? _verifyOTP : _sendOTP,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                                    foregroundColor: Colors.orange.shade600,
                                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                  child: Text(
                                    _isCodeSent ? 'Verify OTP' : 'Send OTP',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                          Spacer(), // Pushes content to the center, removes excess bottom space
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
