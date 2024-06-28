import 'package:flutter/material.dart';

class ReorderPage extends StatefulWidget {
  const ReorderPage({super.key});

  @override
  State<ReorderPage> createState() => _ReorderPageState();
}

class _ReorderPageState extends State<ReorderPage> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(child: Center(child: Text("Screen 4")));
  }
}
