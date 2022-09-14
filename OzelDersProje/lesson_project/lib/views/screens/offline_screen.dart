// ignore_for_file: camel_case_types, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

class offlineScreen extends StatefulWidget {
   offlineScreen({Key? key}) : super(key: key);

  @override
  State<offlineScreen> createState() => _offlineScreenState();
}

class _offlineScreenState extends State<offlineScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Offline'),
      ),
      body: const Center(
        child: Text('Check your internet connection'),
      ),
    );
  }
}
