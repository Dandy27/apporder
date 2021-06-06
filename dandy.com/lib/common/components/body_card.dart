import 'package:flutter/material.dart';
import 'package:pizzaorders2/common/components/pizza_details.dart';
import 'package:pizzaorders2/common/components/pizza_ingredients.dart';
import 'package:pizzaorders2/ingredient.dart';

import '../../constants.dart';

class BodyCard extends StatelessWidget {
  const BodyCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          bottom: defaultPadding * 2.5,
          left: defaultPadding / 2,
          right: defaultPadding / 2,
          child: Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                const Expanded(flex: 5, child: PizzaDetail()),
                const Expanded(flex: 3, child: PizzaIngredients()),
              ],
            ),
          ),
        )
      ],
    );
  }
}
