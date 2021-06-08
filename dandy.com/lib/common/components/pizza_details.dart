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
  final List<Ingredient?> _listIngredients = <Ingredient>[];
  // bool focused = false;
  int price = 15;
  late AnimationController animationController;
  final notifierFocused = ValueNotifier(false);
  List<Animation<num>> animationList = <Animation<num>>[];
  late BoxConstraints _pizzaConstraints;

  Widget buildIngredientsWidget() {
    final List<Widget> elements = [];
    if (animationList.isNotEmpty) {
      for (int i = 0; i < _listIngredients.length; i++) {
        final Ingredient? ingredient = _listIngredients[i];
        final ingredientWidget = Image.asset(
          ingredient!.image,
          height: 40,
        );
        for (int j = 0; j < ingredient.positions.length; j++) {
          final animation = animationList[j];
          final position = ingredient.positions[j];
          final positionX = position.dx;
          final positionY = position.dy;

          if (i == _listIngredients.length - 1) {
            double fromX = 0.0, fromY = 0.0;
            if (j < 1) {
              fromX = -_pizzaConstraints.maxWidth * (1 - animation.value);
            } else if (j < 2) {
              fromX = _pizzaConstraints.maxWidth * (1 - animation.value);
            } else if (j < 4) {
              fromY = -_pizzaConstraints.maxHeight * (1 - animation.value);
            } else {
              fromY = _pizzaConstraints.maxHeight * (1 - animation.value);
            }

            if (animation.value > 0) {
              elements.add(
                Transform(
                  transform: Matrix4.identity()
                    ..translate(
                      fromX + _pizzaConstraints.maxWidth * positionX,
                      fromY + _pizzaConstraints.maxHeight * positionY,
                    ),
                  child: ingredientWidget,
                ),
              );
            } else {
              elements.add(
                Transform(
                  transform: Matrix4.identity()
                    ..translate(
                      _pizzaConstraints.maxWidth * positionX,
                      _pizzaConstraints.maxHeight * positionY,
                    ),
                  child: ingredientWidget,
                ),
              );
            }
          }
        }
        return Stack(
          children: elements,
        );
      }
    }
    return SizedBox.fromSize();
  }

  void _buildIngredientsAnimation() {
    // animationList.clear();
    animationList.add(CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.0, 0.7, curve: Curves.decelerate)));
    // animationList.clear();
    animationList.add(CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.2, 0.7, curve: Curves.decelerate)));
    // animationList.clear();
    animationList.add(CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.4, 1.0, curve: Curves.decelerate)));
    // animationList.clear();
    animationList.add(CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.1, 0.7, curve: Curves.decelerate)));
    // animationList.clear();
    animationList.add(
      CurvedAnimation(
          parent: animationController,
          curve: const Interval(0.3, 0.7, curve: Curves.decelerate)),
    );
    // animationList.clear();
  }

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    animationController.addListener(() => setState(() {}));
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
                    _listIngredients.add(ingredient);
                    price++;
                    _buildIngredientsAnimation();
                    animationController.forward(from: 0.0);
                  });
                },
                onWillAccept: (ingredient) {
                  animationController.reverse();

                  print('onWillAccept');
                  notifierFocused.value = true;

                  for (final Ingredient? i in _listIngredients) {
                    if (i!.compare(ingredient!)) {
                      return false;
                    }
                  }

                  return true;
                },
                onLeave: (data) {
                  animationController.reverse();

                  print('onLeave');
                  notifierFocused.value = false;
                },
                builder: (context, list, reject) {
                  return LayoutBuilder(builder: (context, constraints) {
                    _pizzaConstraints = constraints;
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
                                    'assets/images/wooden_plate2.png',
                                    fit: BoxFit.contain,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child:
                                        Image.asset('assets/images/pizza1.png'),
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
        AnimatedBuilder(
            animation: animationController,
            builder: (context, child) {
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
