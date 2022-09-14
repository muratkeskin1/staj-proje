// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

class statefulDeneme extends StatefulWidget {
  const statefulDeneme({Key? key}) : super(key: key);
  @override
  State<statefulDeneme> createState() => _statefulDenemeState();
}

class _statefulDenemeState extends State<statefulDeneme> {
  late List<String> liste = ["data1", "data2"];
  var myController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.all(10.0),
            itemCount: liste.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                shape: const StadiumBorder(),
                child: Row(children: [
                  Text(liste[index]),
                  TextButton(style: const ButtonStyle(alignment: Alignment.topRight),
                  onPressed:()=> removeFromList(index), child: const Text("çıkart"))],),);},),
          Row(
            children: [  
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: myController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Listeye ekle',
                    ),
                  ),
                )),
                FloatingActionButton(
                onPressed: () {
                  addList(myController.text);
                },
                child: const Icon(Icons.add),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void addList(String text) {
     setState(() {
      liste.add(text);
    });
  }

  void removeFromList(int index) {
     setState(() {
      if(liste.isNotEmpty) {
        liste.removeAt(index);
      } 
    });
  }
}
