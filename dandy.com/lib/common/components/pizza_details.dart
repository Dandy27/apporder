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
      flex: 3,
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
                  price++;
                });
                for (final Ingredient? i in listIngredients) {
                  if (i!.compare(ingredient!)) {
                    return false;
                  }
                }
                listIngredients.add(ingredient);
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
                      duration: const Duration(milliseconds: 300),
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
            height: defaultPadding,
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
          child: Text('\$$price',
              style: const TextStyle(
                color: Colors.brown,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              )),
        );
  }
}
