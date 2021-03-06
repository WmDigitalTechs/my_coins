import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../controllers/rate_my_app_controller.dart';
import 'package:rate_my_app/rate_my_app.dart';
import '../controllers/home_store.dart';

// ignore: must_be_immutable
class LinkEvaluation extends StatelessWidget {
  final rateMyAppController = RateMyAppController();
  final controller = Modular.get<HomeStore>();
  final IconData icon;
  final Color iconcor;
  final double iconSize;
  final double textSize;
  final Color textCor;
  final String text;
  final double rigth;
  final double left;
  final RateMyApp rateMyApp;
  final mounted;

  LinkEvaluation(
      {required this.icon,
      required this.iconcor,
      required this.iconSize,
      required this.textSize,
      required this.textCor,
      required this.text,
      required this.rigth,
      required this.left,
      required this.rateMyApp,
      required this.mounted});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: left, right: rigth),
      child: GestureDetector(
        onTap: () {
          controller.changesColorLinkEvaluation();
          rateMyAppController.initRate(rateMyApp, context, mounted);
          rateMyAppController.setLauchRate(rateMyApp);
        },
        child: Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                icon,
                color: iconcor,
                size: iconSize,
              ),
              const SizedBox(width: 8.0),
              Text(
                text,
                style: TextStyle(color: textCor, fontSize: 18.0),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
