// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

class alertDialog extends StatefulWidget {
  const alertDialog(BuildContext context, {Key? key}) : super(key: key);

  @override
  State<alertDialog> createState() => _alertDialogState();
}

class _alertDialogState extends State<alertDialog> {
  final TextEditingController _controller = TextEditingController();
  late String _text = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_text),
        centerTitle: true,),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            //bottomSheet
            FloatingActionButton(
                child: const Icon(Icons.check),
                onPressed: () {_showModalBottomSheet(context); }),
            //generalDialog
            FloatingActionButton(
              onPressed: () {_showGeneralDialog(context); },
              child: const Icon(Icons.check_box),
            )
          ]),
    );
  }

  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) => Column(
              children: [
                Text(_text),
                TextField(
                  controller: _controller,
                  onChanged: (value) {
                    setState(() {_text = value;}); },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'data ekle',
                  ),
                )
              ],
            ));
  }

  void _showGeneralDialog(BuildContext context) {
    showGeneralDialog(
        context: context,
        pageBuilder: (context, animation, secondaryAnimation) {
          return Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("data"),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.close)),
            ],
          ));
        });
  }
}
