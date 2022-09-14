import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingModal {
  Future<dynamic> showDialogModal(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return  SizedBox(
          height: 200,
          width: 200,
          child: SimpleDialog(
            elevation: 10,
            backgroundColor: Colors.transparent,
            title: Text("Loading".tr().toString()),
            children: const [
              Center(
                child:CircularProgressIndicator(),
              )],),
        );},);}

  SpinKitSpinningLines loadingAnimation(BuildContext context) {
    return const SpinKitSpinningLines(color: Colors.amber);
  }

  void stopLoading(BuildContext context) {
    Navigator.of(context).pop();
  }
}
