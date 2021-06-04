import 'package:flutter/material.dart';

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
              children: [
                Expanded( 
                  flex: 3,
                  child: Column(
                    children: [
                      Expanded(
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
                      const SizedBox(
                        height: defaultPadding,
                      ),
                      const Text('\$15',
                          style: TextStyle(
                            color: Colors.brown,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ))
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
