import 'package:flutter/material.dart';

class StaltessLearn extends StatelessWidget {
  final String text2 = "murat keskin";

  const StaltessLearn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          TextWidget(text: text2),
          const TextWidget(text: "test1"),
          const TextWidget(text: "test2"),
          const TextWidget(text: "test3"),

        ],
      ),
    );
  }

}
class TextWidget extends StatelessWidget {
  const TextWidget({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.headline3,
    );
  }
}