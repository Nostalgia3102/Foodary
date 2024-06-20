import 'package:flutter/material.dart';

Widget windowTile(BuildContext context, String image, String text){
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.deepOrange,
            width: 5.0,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        height: MediaQuery.of(context).size.height * .50,
        width: MediaQuery.of(context).size.width * .80,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: Image.asset(
            image,
            height: MediaQuery.of(context).size.height * .60,
            width: MediaQuery.of(context).size.width * .90,
            fit: BoxFit.cover,
          ),
        ),
      ),
     Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    ],
  );
}