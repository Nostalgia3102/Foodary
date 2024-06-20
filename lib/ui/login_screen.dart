import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/viewmodels/login_screen_view_model.dart';
import '../utils/constants/validations.dart';
import '../utils/utilities.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<LoginScreenViewModel>(
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
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  buildLoginTitle(),
                  buildLoginSubTitle(),
                  const SizedBox(height: 50),
                  Form(
                    key: provider.loginFormKey,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            height: 50,
                            child: buildTextFormFieldEmail(provider),
                          ),
                          const SizedBox(height: 30),
                          SizedBox(
                            height: 50,
                            child: buildTextFormFieldPassword(provider),
                          ),
                          const SizedBox(height: 20),
                          const Text("Forgot your password ?",
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black54)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: SizedBox(
                      width: double.infinity,
                      child: buildElevatedLoginButton(provider, context),
                    ),
                  ),
                  const SizedBox(height: 50),
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
                  const SizedBox(height: 40),
                  buildRowOtherLoginOptions(context),
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
          "Don't have an Account ?",
          style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black54),
        ),
        const SizedBox(width: 12),
        GestureDetector(
          onTap: () {
            navigationService.pushNamed("/sign_up");
          },
          child: const Text(
            "Register Now",
            style: TextStyle(
                color: Colors.deepOrange, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  Row buildRowOtherLoginOptions(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const SizedBox(width: 10),
        IconButton(
            icon: Image.asset(
              'assets/images/fb.png',
              width: MediaQuery.of(context).size.width * 0.08,
            ),
            onPressed: () {}),
        IconButton(
            icon: Image.asset(
              'assets/images/gogl.png',
              width: MediaQuery.of(context).size.width * 0.14,
            ),
            onPressed: () {}),
        const SizedBox(width: 10),
      ],
    );
  }

  ElevatedButton buildElevatedLoginButton(
      LoginScreenViewModel provider, BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.deepOrange),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                side: BorderSide(color: Colors.deepOrange)),
          )),
      onPressed: () async {
        if (provider.loginFormKey.currentState?.validate() ?? false) {
          provider.loginFormKey.currentState?.save();
          bool result =
              await authService.login(provider.email!, provider.password!);
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
          "Login",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  TextFormField buildTextFormFieldPassword(LoginScreenViewModel provider) {
    return TextFormField(
      obscureText: true,
      validator: (value) {
        if (value != null && PASSWORD_VALIDATION_REGEX.hasMatch(value)) {
          provider.password = value;
          return null;
        }
        return "Enter valid password";
      },
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          labelText: "Password"),
    );
  }

  TextFormField buildTextFormFieldEmail(LoginScreenViewModel provider) {
    return TextFormField(
        validator: (value) {
          if (value != null && EMAIL_VALIDATION_REGEX.hasMatch(value)) {
            provider.email = value;
            return null;
          }
          return "Enter valid email id";
        },
        decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            labelText: "Email",
            fillColor: Colors.blue,
            // contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
            // errorStyle: const TextStyle(
            //   color: Colors.red,
            //   fontSize: 14,
            //   fontWeight: FontWeight.normal,
            // ),
            // alignLabelWithHint: true,
            // errorBorder: OutlineInputBorder(
            //   borderRadius: BorderRadius.circular(12),
            //   borderSide: const BorderSide(
            //     color: Colors.red,
            //     width: 2,
            //   ),
            // ),
            // focusedErrorBorder: OutlineInputBorder(
            //   borderRadius: BorderRadius.circular(12),
            //   borderSide: const BorderSide(
            //     color: Colors.redAccent,
            //     width: 2,
            //   ),
            // )
    )
    );
  }

  Text buildLoginSubTitle() {
    return const Text(
      "  Sign in to continue ;-)",
      style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w500),
    );
  }

  Row buildLoginTitle() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          " Welcome ",
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 24),
        ),
        Text(
          "User",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: Colors.deepOrange),
        ),
      ],
    );
  }
}
