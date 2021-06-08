import 'package:flutter/material.dart';

class Ingredient {
  final String image;
  final List<Offset> positions;
  Ingredient(
    this.image,
    this.positions,
  );

  bool compare(Ingredient ingredient) => ingredient.image == image;
}

final ingredients = <Ingredient?>[
  Ingredient(
    'assets/images/toppings/green_chillies_thumb.png',
    <Offset>[
      const Offset(0.2, 0.2),
      const Offset(0.6, 0.2),
      const Offset(0.4, 0.25),
      const Offset(0.5, 0.3),
      const Offset(0.4, 0.65),
    ],
  ),
  Ingredient(
    'assets/images/toppings/olives_thumb.png',
    <Offset>[
      const Offset(0.25, 0.35),
      const Offset(0.65, 0.35),
      const Offset(0.2, 0.23),
      const Offset(0.4, 0.2),
      const Offset(0.2, 0.5),
    ],
  ),
  Ingredient(
    'assets/images/toppings/onions_thumb.png',
    <Offset>[
      const Offset(0.2, 0.5),
      const Offset(0.65, 0.6),
      const Offset(0.25, 0.3),
      const Offset(0.45, 0.2),
      const Offset(0.4, 0.6),
    ],
  ),
  Ingredient(
    'assets/images/toppings/green_peppers_thumb.png',
    <Offset>[
      const Offset(0.2, 0.2),
      const Offset(0.6, 0.2),
      const Offset(0.4, 0.25),
      const Offset(0.5, 0.3),
      const Offset(0.4, 0.65),
    ],
  ),
  Ingredient(
    'assets/images/toppings/halloumi_thumb.png',
    <Offset>[
      const Offset(0.2, 0.35),
      const Offset(0.65, 0.35),
      const Offset(0.3, 0.23),
      const Offset(0.5, 0.2),
      const Offset(0.3, 0.5),
    ],
  ),
  Ingredient(
    'assets/images/toppings/tomatos_thumb.png',
    <Offset>[
      const Offset(0.2, 0.65),
      const Offset(0.65, 0.3),
      const Offset(0.25, 0.25),
      const Offset(0.45, 0.35),
      const Offset(0.4, 0.65),
    ],
  ),
  Ingredient(
    'assets/images/toppings/mushrooms_thumb.png',
    <Offset>[
      const Offset(0.2, 0.2),
      const Offset(0.6, 0.2),
      const Offset(0.4, 0.25),
      const Offset(0.5, 0.3),
      const Offset(0.4, 0.65),
    ],
  ),
];
