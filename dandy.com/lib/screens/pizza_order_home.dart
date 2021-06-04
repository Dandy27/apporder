import 'package:flutter/material.dart';
import 'package:pizzaorders2/common/components/app_bar.dart';
import 'package:pizzaorders2/common/components/body_card.dart';
import 'package:pizzaorders2/constants.dart';

class PizzaOrderHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: const BodyCard(),
    );
  }
}


