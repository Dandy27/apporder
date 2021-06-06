import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pizzaorders2/ingredient.dart';

import '../../constants.dart';

class PizzaDetail extends StatefulWidget {
  const PizzaDetail({
    Key? key,
  }) : super(key: key);

  @override
  _PizzaDetailState createState() => _PizzaDetailState();
}

class _PizzaDetailState extends State<PizzaDetail>
    with SingleTickerProviderStateMixin {
  late final Ingredient ingredient;
  List<Ingredient?> listIngredients = <Ingredient>[];
  // bool focused = false;
  int price = 15;
  late AnimationController animationController;
  final notifierFocused = ValueNotifier(false);
  List<Animation<num>> animationList = <Animation<num>>[];
  late BoxConstraints pizzaConstraints;

  Widget buildIngredientsWidget() {
    final List<Widget> elements = [];
    if (animationList.isNotEmpty) {
      for (int i = 0; i < listIngredients.length; i++) {
        Ingredient? ingredient = listIngredients[i];
        for (int j = 0; j < ingredient!.positions.length; j++) {
          final animation = animationList[j];
          final position = ingredient.positions[j];
          final positionX = position.dx;
          final positionY = position.dy;
          double fromX = 0.0, fromY = 0.0;
          if (j < 1) {
            fromX = -pizzaConstraints.maxWidth * (1 - animation.value);
          } else if (j < 2) {
            fromX = pizzaConstraints.maxWidth * (1 - animation.value);
          } else if (j < 4) {
            fromY = -pizzaConstraints.maxHeight * (1 - animation.value);
          } else {
            fromY = pizzaConstraints.maxHeight * (1 - animation.value);
          }

          elements.add(Transform(
            transform: Matrix4.identity()
              ..translate(
                fromX + pizzaConstraints.maxWidth * positionX,
                fromY + pizzaConstraints.maxHeight * positionY,
              ),
            child: Image.asset(
              ingredient.image,
              height: 40,
            ),
          ));

          return Stack(
            children: elements,
          );

          
        }
       
      }
       
    }
    return SizedBox.fromSize();
  }

  void buildIngredientsAnimation() {
    animationList.clear();
    animationList.add(CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.0, 0.8, curve: Curves.decelerate)));
    animationList.clear();
    animationList.add(CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.2, 0.8, curve: Curves.decelerate)));
    animationList.clear();
    animationList.add(CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.4, 1.0, curve: Curves.decelerate)));
    animationList.clear();
    animationList.add(CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.1, 0.7, curve: Curves.decelerate)));
    animationList.clear();
    animationList.add(CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.3, 1.0, curve: Curves.decelerate)));
  }

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(microseconds: 900),
    );
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              child: DragTarget<Ingredient>(
                onAccept: (ingredient) {
                  print('onAccept');
                  notifierFocused.value = false;
                  setState(() {
                    listIngredients.add(ingredient);
                    price++;
                    buildIngredientsAnimation();
                    animationController.forward(from: 0.0);
                  });
                },
                onWillAccept: (ingredient) {
                  print('onWillAccept');
                  notifierFocused.value = true;

                  for (Ingredient? i in listIngredients) {
                    if (i!.compare(ingredient!)) {
                      return false;
                    }
                  }

                  return true;
                },
                onLeave: (data) {
                  print('onLeave');
                  notifierFocused.value = false;
                },
                builder: (context, list, reject) {
                  return LayoutBuilder(builder: (context, constraints) {
                    pizzaConstraints = constraints;
                    return Center(
                      child: ValueListenableBuilder<bool>(
                          valueListenable: notifierFocused,
                          builder: (context, focused, _) {
                            return AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              height: focused
                                  ? constraints.maxHeight
                                  : constraints.maxHeight - 10,
                              child: Stack(
                                children: [
                                  Image.asset(
                                    'assets/images/dish.png',
                                    fit: BoxFit.contain,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Image.asset(
                                        'assets/images/pizza-1.png'),
                                  )
                                ],
                              ),
                            );
                          }),
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
        AnimatedBuilder(animation: animationController, builder: (context, _){
        return buildIngredientsWidget();
          
        })
      ],
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
          key: UniqueKey(),
          style: const TextStyle(
            color: Colors.brown,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          )),
    );
  }
}
