import 'package:flutter/material.dart';

import 'package:my_office_th_app/screens/inventory/item_state_container.dart';

class ItemPagePhotos extends StatelessWidget {

  final List<String> listImagePath;

  ItemPagePhotos(this.listImagePath);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
          children: (this.listImagePath)
              .map((f) => Image.network(
                    f,
                    fit: BoxFit.cover,
                    height: double.infinity,
                    width: double.infinity,
                    alignment: Alignment.center,
                  ))
              .toList()),
    );
  }
}