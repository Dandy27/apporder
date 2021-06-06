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

class _PizzaDetailState extends State<PizzaDetail>
    with SingleTickerProviderStateMixin {
  late final Ingredient ingredient;
  List<Ingredient?> listIngredients = <Ingredient>[];
  // bool focused = false;
  int price = 15;
  late AnimationController animationController;
  final notifierFocused = ValueNotifier(false);
  List<Animation> animationList = <Animation>[];

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
        curve: const Interval(0.4,1.0, curve: Curves.decelerate)));
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
    return Expanded(
      flex: 5,
      child: Column(
        children: [
          Expanded(
            child: DragTarget<Ingredient>(
              onAccept: (ingredient) {
                print('onAccept');
                notifierFocused.value = false;
                setState(() {
                  listIngredients.add(ingredient);
                  price++;
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
                                  child:
                                      Image.asset('assets/images/pizza-1.png'),
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
