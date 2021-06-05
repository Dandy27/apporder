import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../ingredient.dart';

class PizzaIngredients extends StatelessWidget {
  const PizzaIngredients({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 3,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: ingredients.length,
            itemBuilder: (context, index) {
              final ingredient = ingredients[index];
              final child = Padding(
                padding: const EdgeInsets.all(12.5),
                child: Container(
                  padding: const EdgeInsets.all(4),
                  height: defaultPadding * 2.5,
                  width: defaultPadding * 2.5,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Color(0xFFF5EED3)),
                  child: Image.asset(ingredient!.image),
                ),
              );
              return Center(
                child: Draggable(
                  feedback: child,
                  data: ingredient,
                  // childWhenDragging: Container(color: const Color(0xFFF5EED3),),
                  child: child,
                ),
              );
            }));
  }
}
