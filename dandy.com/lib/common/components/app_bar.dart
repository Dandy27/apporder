import 'package:flutter/material.dart';

import '../../constants.dart';



  AppBar buildAppBar() {
    return AppBar(
      actions: [
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.add_shopping_cart_outlined,
              color: Colors.brown,
              size: 30,

            )),
           const  SizedBox(width: defaultPadding / 2,)
          
      ],
      elevation: 0,
      backgroundColor: Colors.white,
      title: const Text(
        'Vegan Pizza',
        style: TextStyle(
          color: Colors.brown,
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
    );
  }