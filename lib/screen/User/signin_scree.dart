import 'package:flutter/material.dart';

import '../../apis/user_api.dart';
import '../../components/app_properties.dart';
import '../../components/error _snackbar.dart';
import '../../components/route.dart';
import '../../components/share_prefs.dart';
import '../../components/user_input_feild.dart';

class StartUp extends StatefulWidget {
  StartUp({super.key});

  @override
  State<StartUp> createState() => _StartUpState();
}

class _StartUpState extends State<StartUp> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  final UserInputFeild feild = UserInputFeild();
  bool _isLoading = false;
  bool isOtp = false;
  bool userRegisterd = false;
  int otp = 0;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _sendDataToServer() async {
    try {
      Map<dynamic, dynamic> data = await ApiService.sendDataToServer(
        email: _emailController.text,
      );
      if (data['success']) {
        userRegisterd = data['userExist'];
        otp = int.parse(data['otp']);
        SharePrefs.storePrefs("email", _emailController.text, "string");
        isOtp = true;
      } else {
        // write code for snackbar error
      }
    } catch (error) {
      print('Error: $error');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _OTPAction() async {
    try {
      if (otp == int.parse(_otpController.text)) {
        if (userRegisterd) {
          RouterClass.ReplaceScreen(context, "/home");
        } else {
          RouterClass.ReplaceScreen(context, "/userData");
        }
      }
    } catch (error) {
      print("Error: $error");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: BackgroundColor,
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/sign.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              children: [
                Expanded(
                  child: SizedBox(
                    height: mediaQuery.height,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: mediaQuery.height * .2,
                          ),
                          //     Center(
                          //   child: Padding(
                          //     padding: const EdgeInsets.fromLTRB(25.0, 50.0, 25.0, 5.0),
                          //     child: Container(
                          //       height:mediaQuery.height*.4,
                          //       // width: 200,
                          //       decoration: BoxDecoration(
                          //         color: BackgroundColor
                          //       ),
                          //       child: Image.asset(
                          //         "assets/logo.png"
                          //       )
                          //     ),
                          //   ),
                          // ),
                          Center(
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(
                                  25.0, 0.0, 25.0, 7.0),
                              child: const Center(
                                  child: Text(
                                'Coffe Urge!',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 70,
                                  fontFamily: AutofillHints.addressCity,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              )),
                            ),
                          ),
                          Center(
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(
                                  25.0, 0.0, 25.0, 7.0),
                              child: const Center(
                                  child: Text(
                                "Indulge, Immerse, Sip & Savor!",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              )),
                            ),
                          ),
                          Center(
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(
                                  25.0, 0.0, 25.0, 15.0),
                              child: const Center(
                                child: Text(
                                    '"Discover ExBooks: Begin Your Reading Adventure!"',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                    )),
                              ),
                            ),
                          ),
                          feild.inputContainerText(context, _emailController,
                              "Enter Email", Icon(Icons.email_outlined)),
                          isOtp
                              ? Column(
                                  children: [
                                    const SizedBox(height: 15),
                                    feild.inputContainerText(
                                        context,
                                        _otpController,
                                        "Enter OTP",
                                        Icon(Icons.password_outlined)),
                                    SizedBox(height: 20.0),
                                    feild.buttonContainer(context, "Verify OTP",
                                        () async {
                                      if (_otpController.text.isEmpty) {
                                        InputComponent.showWarningSnackBar(
                                            context, "Enter Valid OTP");
                                      } else {
                                        setState(() {
                                          _isLoading = true;
                                        });
                                        await _OTPAction();
                                      }
                                    }, _isLoading)
                                  ],
                                )
                              : Column(
                                  children: [
                                    const SizedBox(height: 15),
                                    feild.buttonContainer(context, "Join",
                                        () async {
                                      if (_emailController.text.isEmpty) {
                                        InputComponent.showWarningSnackBar(
                                            context, "Enter Valid Email");
                                      } else {
                                        setState(() {
                                          _isLoading = true;
                                        });
                                        await _sendDataToServer(); // Call the function directly
                                      }
                                    }, _isLoading)
                                  ],
                                ),
                        ],
                      ),
                    ),
                  ),
                ),
                
              ],
            )
          ],
        ));
  }
}
