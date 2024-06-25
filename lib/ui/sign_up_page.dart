import 'package:flutter/material.dart';
import 'package:foodary/data/viewmodels/signup_screen_view_model.dart';
import 'package:provider/provider.dart';

import '../utils/constants/strings.dart';
import '../utils/constants/validations.dart';
import '../utils/utilities.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String? name, email, password;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SignUpScreenViewModel>(
      builder: (context, provider, child) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            centerTitle: true,
            title: Image.asset(
              "assets/images/canvaFoodary.png",
              fit: BoxFit.fill,
              height: 64,
              width: 200,
            ),
          ),
          body: SafeArea(
            maintainBottomViewPadding: true,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  SizedBox(height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.025),
                  buildSignUpTitle(),
                  buildSignUpSubTitle(),
                  SizedBox(height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.04),
                  Form(
                    key: provider.signUpFormKey,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                              height: 60.0,
                              child: buildTextFormField(
                                  provider,
                                  StringsAsset.enterName,
                                  StringsAsset.nameLabelText)),
                          SizedBox(height: MediaQuery
                              .of(context)
                              .size
                              .height * 0.02),
                          SizedBox(
                              height: 60.0,
                              child: buildTextFormField(
                                  provider,
                                  StringsAsset.enterEmail,
                                  StringsAsset.emailLabelText)),
                          SizedBox(height: MediaQuery
                              .of(context)
                              .size
                              .height * 0.02),
                          SizedBox(
                            height: 60,
                            child: buildTextFormField(
                                provider,
                                StringsAsset.enterPassword,
                                StringsAsset.passwordLabelText),
                          ),
                          SizedBox(height: MediaQuery
                              .of(context)
                              .size
                              .height * 0.02),
                          SizedBox(
                            height: 60,
                            child: InternationalPhoneNumberInput(
                              keyboardType: TextInputType.phone,
                              autoFocusSearch: true,
                              inputDecoration: InputDecoration(
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                                  labelText: StringsAsset.phoneNumberLabelText,
                                  fillColor: Colors.blue,
                                  contentPadding:
                                  const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                                  errorStyle: const TextStyle(
                                    color: Colors.red,
                                    fontSize: 12,
                                    height: 0.3,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  alignLabelWithHint: true,
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                      color: Colors.red,
                                      width: 2,
                                    ),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(
                                        color: Colors.redAccent,
                                        width: 2,
                                      ),
                                      gapPadding: 0)),
                              onInputChanged: (value) {
                                provider.phoneNumber = value.phoneNumber;
                              },
                            ),
                          ),
                          SizedBox(height: MediaQuery
                              .of(context)
                              .size
                              .height * 0.025),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.0),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: SizedBox(
                      width: double.infinity,
                      child: buildElevatedSignUpButton(provider, context),
                    ),
                  ),
                  SizedBox(height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.045),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 100,
                        height: 1,
                        child: Container(
                          color: Colors.black54,
                        ),
                      ),
                      const Text(
                        "  Continue with  ",
                        style: TextStyle(color: Colors.black54),
                      ),
                      SizedBox(
                        width: 100,
                        height: 1,
                        child: Container(
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.025),
                  buildRowOtherSignUpOptions(context, provider),
                  Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 8, 8, 14),
                        child: buildRowFooterText(),
                      ))
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Row buildRowFooterText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Text(
          "Have an Account ?",
          style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black54),
        ),
        const SizedBox(width: 12),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Text(
            "Sign In",
            style: TextStyle(
                color: Colors.deepOrange, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  Row buildRowOtherSignUpOptions(BuildContext context,
      SignUpScreenViewModel provider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(width: MediaQuery
            .of(context)
            .size
            .height * 0.05),
        IconButton(
            icon: Image.asset(
              'assets/images/fb.png',
              width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.08,
            ),
            onPressed: () async {
              try {
                bool res = await authService.signUpWithFacebook();
                if (res) {
                  navigationService.pushReplacementNamed("/home_page");
                } else {
                  final snackBar = SnackBar(
                    content: const Text(
                        'User does not exists, Please register - FB'),
                    duration: const Duration(seconds: 2),
                    action: SnackBarAction(
                      label: 'Close',
                      onPressed: () {
                        // Some action to undo
                      },
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              } catch (e) {
                print(e);
              }
            }),
        SizedBox(width: MediaQuery
            .of(context)
            .size
            .height * 0.01),
        IconButton(
            icon: Image.asset(
              'assets/images/gogl.png',
              width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.14,
            ),
            onPressed: () async {
              try {
                bool result =
                await authService.signUpWithGoogle();
                print(result);
                if (result) {
                  navigationService.pushReplacementNamed("/home_page");
                } else {
                  final snackBar = SnackBar(
                    content: const Text('User Already Exists Please Login'),
                    duration: const Duration(seconds: 2),
                    action: SnackBarAction(
                      label: 'Close',
                      onPressed: () {
                        // Some action to undo
                      },
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              } catch (e) {
                debugPrint(e.toString());
              }
            }),
        SizedBox(width: MediaQuery
            .of(context)
            .size
            .height * 0.05),
      ],
    );
  }

  ElevatedButton buildElevatedSignUpButton(SignUpScreenViewModel provider,
      BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(Colors.deepOrange),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                side: BorderSide(color: Colors.deepOrange)),
          )),
      onPressed: () async {
        if (provider.signUpFormKey.currentState?.validate() ?? false) {
          provider.signUpFormKey.currentState?.save();
          bool result =
          await authService.register(provider.email!, provider.password!);
          print(result);
          if (result) {
            navigationService.pushReplacementNamed("/home_page");
          } else {
            final snackBar = SnackBar(
              content: const Text('Invalid Credentials'),
              duration: const Duration(seconds: 2),
              action: SnackBarAction(
                label: 'Undo',
                onPressed: () {
                  // Some action to undo
                },
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        }
      },
      child: const Padding(
        padding: EdgeInsets.all(12),
        child: Text(
          "Register",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  TextFormField buildTextFormField(SignUpScreenViewModel provider,
      String cautionText, String labelText) {
    return TextFormField(

        keyboardType: (labelText == "Phone Number")
            ? TextInputType.phone
            : TextInputType.text,

        validator: (value) {
          if (value != null &&
              labelText == "Full Name" &&
              EMAIL_VALIDATION_REGEX.hasMatch(value)) {
            provider.name = value;
            return null;
          }

          if (value != null &&
              labelText == "Email" &&
              EMAIL_VALIDATION_REGEX.hasMatch(value)) {
            provider.email = value;
            return null;
          }

          if (value != null &&
              labelText == "Password" &&
              PASSWORD_VALIDATION_REGEX.hasMatch(value)) {
            provider.password = value;
            return null;
          }

          return cautionText;
        },
        decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            labelText: labelText,
            fillColor: Colors.blue,
            contentPadding:
            const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            errorStyle: const TextStyle(
              color: Colors.red,
              fontSize: 12,
              height: 0.3,
              fontWeight: FontWeight.normal,
            ),
            alignLabelWithHint: true,
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Colors.red,
                width: 2,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Colors.redAccent,
                  width: 2,
                ),
                gapPadding: 0)));
  }

  Text buildSignUpSubTitle() {
    return const Text(
      "  Fill in your registration information",
      style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w500),
    );
  }

  Row buildSignUpTitle() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          " Sign ",
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 24),
        ),
        Text(
          "Up",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: Colors.deepOrange),
        ),
      ],
    );
  }
}
