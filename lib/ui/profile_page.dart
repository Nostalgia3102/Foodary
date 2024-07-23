import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:foodary/data/viewmodels/profile_page_view_model.dart';
import 'package:foodary/utils/constants/strings.dart';
import 'package:foodary/utils/utilities.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _eventToken = 'not yet';

  @override
  void initState() {
    // TODO: implement initState
    appCheck.onTokenChange.listen(setEventToken);
    super.initState();
  }

  void setEventToken(String? token) {
    setState(() {
      _eventToken = token ?? 'not yet';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfilePageViewModel>(
      builder: (context, provider, child) {
        DateTime? dob;
        if (provider.textContollerDOB.text.isNotEmpty) {
          dob = DateFormat('yyyy-MM-dd').parse(provider.textContollerDOB.text);
        }
        DateTime? anni;
        if (provider.textContollerAnniversary.text.isNotEmpty) {
          anni = DateFormat('yyyy-MM-dd')
              .parse(provider.textContollerAnniversary.text);
        }
        if (provider.flag) {
          profileDataGet(provider).whenComplete(() {
            provider.flag = false;
          });
        }
        return PopScope(
          onPopInvoked: (_) => provider.flag = true,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: const Text(
                "Your Profile",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    fontSize: 22),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.fromLTRB(22, 12, 22, 8),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 66,
                      backgroundColor: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8), // Border radius
                        child: ClipOval(
                            child: provider.image != null
                                ? Image.file(File(provider.image!.path))
                                : const Image(
                                    image:
                                        AssetImage("assets/images/imggg.jpg"))),
                      ),
                    ),
                    GestureDetector(
                        onTap: () async {
                          print("Tapped on edit");
                          provider.image = await provider.picker.pickImage(
                            source: ImageSource.gallery,
                          );
                        },
                        child: const Icon(Icons.edit)),
                    Form(
                        child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 40,
                          ),
                          TextFormField(
                              controller: provider.textContollerName,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  labelText: "Name",
                                  fillColor: Colors.blue,
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 12),
                                  errorStyle: const TextStyle(
                                    color: Colors.red,
                                    fontSize: 12,
                                    height: 0.5,
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
                                      gapPadding:
                                          BorderSide.strokeAlignOutside))),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                              controller: provider.textContollerMobile,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  labelText: "Mobile",
                                  fillColor: Colors.blue,
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 12),
                                  errorStyle: const TextStyle(
                                    color: Colors.red,
                                    fontSize: 12,
                                    height: 0.5,
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
                                      gapPadding:
                                          BorderSide.strokeAlignOutside))),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                              controller: provider.textContollerEmail,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  labelText: "Email",
                                  fillColor: Colors.blue,
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 12),
                                  errorStyle: const TextStyle(
                                    color: Colors.red,
                                    fontSize: 12,
                                    height: 0.5,
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
                                      gapPadding:
                                          BorderSide.strokeAlignOutside))),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime(2101),
                                );
                                if (pickedDate != null) {
                                  provider.textControllerDOB = pickedDate;
                                }
                              },
                              showCursor: true,
                              readOnly: true,
                              controller: provider.textContollerDOB,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  labelText: "Date of birth",
                                  fillColor: Colors.blue,
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 12),
                                  errorStyle: const TextStyle(
                                    color: Colors.red,
                                    fontSize: 12,
                                    height: 0.5,
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
                                      gapPadding:
                                          BorderSide.strokeAlignOutside))),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime(2101),
                                );
                                if (pickedDate != null) {
                                  provider.textControllerAnniversary =
                                      pickedDate;
                                }
                              },
                              showCursor: true,
                              readOnly: true,
                              controller: provider.textContollerAnniversary,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  labelText: "Anniversary",
                                  fillColor: Colors.blue,
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 12),
                                  errorStyle: const TextStyle(
                                    color: Colors.red,
                                    fontSize: 12,
                                    height: 0.5,
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
                                      gapPadding:
                                          BorderSide.strokeAlignOutside))),
                          const SizedBox(
                            height: 20,
                          ),
                          DropdownButtonFormField<String>(
                            value: provider.selectedGender,
                            items: <String>['male', 'female', 'others']
                                .map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                provider.selectedGender = newValue;
                              }
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              labelText: "Gender",
                              fillColor: Colors.blue,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 12),
                              errorStyle: const TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                                height: 0.5,
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
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                        ],
                      ),
                    ))
                  ],
                ),
              ),
            ),
            bottomSheet: BottomSheet(
              enableDrag: false,
              onClosing: () {},
              builder: (context){
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: const ButtonStyle(
                        elevation: WidgetStatePropertyAll(5),
                        backgroundColor: WidgetStatePropertyAll(Colors.white)),
                    onPressed: () async {
                      print("THE UID IS -> ${authService.user!.uid}");
                      debugPrint("HELLO");
                      try {

                        // Token will be passed to `onTokenChange()` event handler
                        await appCheck.getToken(true);

                        await appCheck.setTokenAutoRefreshEnabled(true);
                        print('successfully set auto token refresh!!');

                        // await authService.user!.verifyBeforeUpdateEmail(
                        //     provider.textContollerEmail.text.toString());

                        if (provider.image == null) return;

                        //get reference of storage root :
                        Reference refRoot = FirebaseStorage.instance.ref();
                        Reference refDir = refRoot.child('images');

                        // create reference for the image to be stored :
                        Reference imageToUpload = await refDir
                            .child("${authService.user!.uid}.jpeg");
                        print("the path of image is $imageToUpload");
                        await imageToUpload.putFile(File(provider.image!.path));
                        provider.imageUrl = await imageToUpload.getDownloadURL();

                        print(provider.imageUrl.toString());

                        String? token = await FirebaseAppCheck.instance.getToken();
                        print("THE TOKEN IS -> $token");


                        Map<String, Object> data = {
                          'name': provider.textContollerName.text.toString(),
                          'phone': int.parse(
                              provider.textContollerMobile.text.toString()),
                          'dob': dob != null
                              ? Timestamp.fromDate(dob)
                              : FieldValue.delete(),
                          'anniversary': anni != null
                              ? Timestamp.fromDate(anni)
                              : FieldValue.delete(),
                          'email': provider.textContollerEmail.text.toString(),
                          'gender': provider.selectedGender.toString(),
                          'image' : provider.imageUrl.toString()
                        };

                        await appCheck.activate(
                          webProvider: ReCaptchaV3Provider(StringsAsset.kWebRecaptchaSiteKey),
                        );
                        print('activated!!');

                        await firebaseFirestore
                            .collection("users")
                            .doc(authService.user!.uid)
                            .set(data);

                      } catch (e) {
                        print("the error is $e");
                      }
                    },
                    child: SizedBox(
                        height: MediaQuery.of(context).size.height * .07,
                        width: MediaQuery.of(context).size.width,
                        child: Container(
                            alignment: Alignment.center,
                            child: const Text("Update Profile"))),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Future<void> profileDataGet(ProfilePageViewModel provider) async {
    print("UID OF CURRENT USER");
    print(authService.user?.uid.toString());
    DocumentSnapshot<Map<String, dynamic>> up = await firebaseFirestore
        .collection("users")
        .doc(authService.user!.uid)
        .get();
    provider.textControllerName = up.get('name').toString();
    provider.textControllerMobile = up.get('phone').toString();
    provider.textControllerEmail = up.get('email').toString();
    Timestamp dobTime = up.get('dob');
    setDOBFromTimestamp(dobTime.seconds, dobTime.nanoseconds, provider);
    Timestamp anniversaryTime = up.get('anniversary');
    setAnniversaryFromTimestamp(
        anniversaryTime.seconds, anniversaryTime.nanoseconds, provider);
    provider.selectedGender = up.get('gender').toString();
  }

  // Set method for Timestamp
  void setDOBFromTimestamp(
      int seconds, int nanoseconds, ProfilePageViewModel provider) {
    int milliseconds = seconds * 1000 + nanoseconds ~/ 1000000;
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(milliseconds);
    provider.textControllerDOB = dateTime; // This will trigger the setter
  }

  void setAnniversaryFromTimestamp(
      int seconds, int nanoseconds, ProfilePageViewModel provider) {
    int milliseconds = seconds * 1000 + nanoseconds ~/ 1000000;
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(milliseconds);
    provider.textControllerAnniversary =
        dateTime; // This will trigger the setter
  }
}
