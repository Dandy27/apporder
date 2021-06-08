import 'package:flutter/material.dart';
import 'package:pizzaorders2/common/components/pizza_details.dart';
import 'package:pizzaorders2/common/components/pizza_ingredients.dart';

import '../../constants.dart';

const _pizzaCardSize = 50.0;

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
                const SizedBox(height: defaultPadding,),
                const Expanded(flex: 3, child: PizzaDetail()),
                const Expanded(flex: 3, child: PizzaIngredients()),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 40,
          height: _pizzaCardSize,
          width: _pizzaCardSize,
          left: MediaQuery.of(context).size.width / 2 - _pizzaCardSize / 2,
          child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.orange.withOpacity(0.5),
                    Colors.orange,
                  ],
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.shopping_cart_outlined,
                ),
                color: Colors.white,
                iconSize: 30,
              )),
        )
      ],
    );
  }
}

// Widget buildButtonCart(
//         {required BuildContext context,
//         required VoidCallback press,
//         required Icon icon}) =>
//     Positioned(
//       bottom: 35,
//       height: 50,
//       width: 50,
//       left: MediaQuery.of(context).size.width / 2 - 50 / 2,
//       child: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//               colors: [
//                 Colors.orange.withOpacity(0.5),
//                 Colors.orange,
//               ],
//             ),
//             borderRadius: BorderRadius.circular(5),
//           ),
//           child: IconButton(
//             onPressed: press,
//             icon: icon,
//             color: Colors.white,
//             iconSize: 35,
//           )),
//     );