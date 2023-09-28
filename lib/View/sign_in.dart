import 'package:another_flushbar/flushbar.dart';
import 'package:buts_conductor_app/Controller/provider.dart';
import 'package:buts_conductor_app/View/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kAccentBlue,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          reverse: true,
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 75),
                        color: kAccentBlue,
                        child: Image.asset(
                          'assets/images/Logo1.png'
                        ),
                      )),
                  Consumer<AppProvider>(
                    builder: (context, controller, child){
                      return Container(
                        height: 325,
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 0,
                                blurRadius: 10,
                                offset: const Offset(
                                    0, 4), // changes position of shadow
                              ),
                            ],
                            color: kYellow,
                            borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(30),
                                topLeft: Radius.circular(30))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Sign In",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                            Container(
                              height: 50,
                              padding: const EdgeInsets.only(right: 5),
                              decoration: const BoxDecoration(
                                  color: kAccentBlue,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(20))),
                              child: Center(
                                child: TextField(
                                  onChanged: (value) {
                                    controller.updateEmail(value);
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.done,
                                  decoration: const InputDecoration(
                                      hintText: "Email",
                                      hintStyle:
                                      TextStyle(fontSize: 15),
                                      prefixIcon: Icon(
                                        Icons.email,
                                        color: Colors.grey,
                                      ),
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.symmetric(vertical: 15)),
                                ),
                              ),
                            ),
                            Container(
                              height: 50,
                              padding: const EdgeInsets.only(right: 5),
                              decoration: const BoxDecoration(
                                  color: kAccentBlue,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(20))),
                              child: Center(
                                child: TextField(
                                  onChanged: (value) {
                                    controller.updatePassword(value);
                                  },
                                  obscureText: !controller.isPassVisible,
                                  keyboardType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.done,
                                  decoration: InputDecoration(
                                      hintText: "Password",
                                      hintStyle:
                                      const TextStyle(fontSize: 15),
                                      prefixIcon: const Icon(
                                        Icons.password,
                                        color: Colors.grey,
                                      ),
                                      suffixIcon: controller.password.isEmpty
                                          ? null
                                          : IconButton(color: Colors.grey,
                                        icon: Icon(!controller.isPassVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off),
                                        onPressed: () {
                                          controller.togglePasswordVisibility();
                                        },
                                      ),
                                      border: InputBorder.none,
                                      contentPadding:
                                      const EdgeInsets.symmetric(
                                          vertical: 15)),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                    onTap: () async {
                                      // try {
                                      //   await controller.forgotPasswordSendOTP(Provider.of<VerifyEmailProvider>(context,listen: false).getEmail);
                                      //   if(controller.otpSent){
                                      //     Navigator.push(context, MaterialPageRoute(builder: (context) => VerifyOtpScreen(
                                      //       isForgotPasswordScreen: true,
                                      //     )));
                                      //   }
                                      // } catch(e) {
                                      //   Flushbar(
                                      //     message: e.toString(),
                                      //     icon: Icon(
                                      //       Icons.info_outline,
                                      //       size: 28.0,
                                      //       color: Colors.blue[300],
                                      //     ),
                                      //     duration: const Duration(seconds: 2),
                                      //     leftBarIndicatorColor: Colors.blue[300],
                                      //     flushbarPosition: FlushbarPosition.TOP,
                                      //   ).show(context);
                                      // }
                                    },
                                    child: const Text('Forgot Password?')
                                ),
                              ],
                            ),
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () async {
                                  FocusScope.of(context).requestFocus(FocusNode());
                                  if(controller.password.isEmpty || controller.password.length < 6){
                                    Flushbar(
                                      message: "Password length should be more than 6",
                                      icon: Icon(
                                        Icons.info_outline,
                                        size: 28.0,
                                        color: Colors.blue[300],
                                      ),
                                      duration: const Duration(seconds: 2),
                                      leftBarIndicatorColor: Colors.blue[300],
                                      flushbarPosition: FlushbarPosition.TOP,
                                    ).show(context);
                                  } else {
                                    try {
                                      await controller.login();
                                      if(controller.signedIn){
                                        print(controller.token);
                                        controller.updateState(ViewState.busy);
                                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                                          return HomeScreen();
                                        }));
                                      }
                                    } catch(e) {
                                      Flushbar(
                                        message: e.toString(),
                                        icon: const Icon(
                                          Icons.info_outline,
                                          size: 28.0,
                                          color: kBlue,
                                        ),
                                        duration: const Duration(seconds: 2),
                                        leftBarIndicatorColor: Colors.blue[300],
                                        flushbarPosition: FlushbarPosition.TOP,
                                      ).show(context);
                                    }
                                  }
                                },
                                child: Ink(
                                  height: 50,
                                  decoration: const BoxDecoration(
                                    color: kBlue,
                                    borderRadius: BorderRadius.all(
                                        (Radius.circular(20))),
                                  ),
                                  child: Center(
                                    child: controller.state == ViewState.busy
                                        ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(color: kWhite, strokeWidth: 2,),
                                    )
                                        : const Text(
                                      'Sign In',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
