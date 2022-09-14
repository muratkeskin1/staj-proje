import 'dart:convert';

import 'package:flutter/services.dart';

class ReadJsonMessages {
  Future<dynamic> readJson() async {
    final String response =
        await rootBundle.loadString('assets/translations/en.json');
    final messages = await json.decode(response);
    return await messages;
  }
}
