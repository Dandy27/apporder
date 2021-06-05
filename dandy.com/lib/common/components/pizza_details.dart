import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pizzaorders2/ingredient.dart';

import '../../constants.dart';
// import '../../ingredient.dart';

class PizzaDetail extends StatefulWidget {
  const PizzaDetail({
    Key? key,
  }) : super(key: key);

  @override
  _PizzaDetailState createState() => _PizzaDetailState();
}

class _PizzaDetailState extends State<PizzaDetail> {
  late final Ingredient ingredient;
  List<Ingredient?> listIngredients = <Ingredient>[];
  bool focused = false;
  int price = 15;

  @override
  Widget build(
    BuildContext context,
  ) {
    return Expanded(
      flex: 5,
      child: Column(
        children: [
          Expanded(
            child: DragTarget<Ingredient>(
              onAccept: (ingredient) {
                print('onAccept');
                setState(() {
                  focused = false;
                });
              },
              onWillAccept: (ingredient) {
                print('onWillAccept');
                setState(() {
                  focused = true;
                  // price++;
                });
                for (final Ingredient? i in listIngredients) {
                  if (i!.compare(ingredient!)) {
                    return false;
                  }
                }
                listIngredients.add(ingredient);
                price++;
                return true;
              },
              onLeave: (data) {
                print('onLeave');
                setState(() {
                  focused = false;
                });
              },
              builder: (context, list, reject) {
                return LayoutBuilder(builder: (context, constraints) {
                  return Center(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      height: focused
                          ? constraints.maxHeight
                          : constraints.maxHeight - 20,
                      child: Stack(
                        children: [
                          Image.asset(
                            'assets/images/dish.png',
                            fit: BoxFit.contain,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Image.asset('assets/images/pizza-1.png'),
                          )
                        ],
                      ),
                    ),
                  );
                });
              },
            ),
          ),
          const SizedBox(
            height: defaultPadding / 3,
          ),
          // builText()
          buidText()
        ],
      ),
    );
  }

  Widget buidText() {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: animation.drive(Tween<Offset>(
              begin: const Offset(0.0, 0.0),
              end: Offset(0.0, animation.value),
            )),
            child: child,
          ),
        );
      },
      child: Text('\$$price',
          key:UniqueKey(),
          style: const TextStyle(
            color: Colors.brown,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          )),
    );
  }
}
