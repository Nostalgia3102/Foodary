import 'package:flutter/material.dart';

import '../utils/constants/validations.dart';
import '../utils/utilities.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _registerFormKey = GlobalKey();
  String? name, email, password;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Let's Get Going!",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 24),
              ),
              const Text("Register your account using the form below"),
              const SizedBox(
                height: 30,
              ),
              Form(
                key: _registerFormKey,
                child: Column(
                  children: [
                    CircleAvatar(
                        radius: MediaQuery.of(context).size.width * 0.15),
                    const SizedBox(height: 30),
                    TextFormField(
                      validator: (value) {
                        if (value != null &&
                            NAME_VALIDATION_REGEX.hasMatch(value)) {
                          name = value;
                          return null;
                        }
                        return "Enter valid name";
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          hintText: "Name"),
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      validator: (value) {
                        if (value != null &&
                            EMAIL_VALIDATION_REGEX.hasMatch(value)) {
                          email = value;
                          return null;
                        }
                        return "Enter valid email id";
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          hintText: "Email"),
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      obscureText: true,
                      validator: (value) {
                        if (value != null &&
                            PASSWORD_VALIDATION_REGEX.hasMatch(value)) {
                          password = value;
                          return null;
                        }
                        return "Enter valid password";
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          hintText: "Password"),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_registerFormKey.currentState?.validate() ?? false) {
                      _registerFormKey.currentState?.save();
                      bool result =
                      await authService.register(email!, password!);
                      if (result) {
                        if (name != null) {
                          try{
                            // await databaseServices.createUserProfile(
                            //     userProfile: UserProfile(
                            //         uid: authService.user!.uid, name: name));
                            navigationService.pushReplacementNamed("/home_page");
                          }catch(e){
                            print("Unable to register the user");
                            print(e);
                          }
                        }
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
                  child: const Text("Register"),
                ),
              ),
              Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text("Already have an Account ?"),
                      const SizedBox(
                        width: 12,
                      ),
                      GestureDetector(
                        onTap: () {
                          navigationService.goBack();
                        },
                        child: const Text(
                          "Login",
                          style: TextStyle(color: Colors.blue),
                        ),
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
