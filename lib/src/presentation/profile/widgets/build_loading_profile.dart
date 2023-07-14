import 'package:flutter/material.dart';

import '../../../core/widgets/item_loading.dart';
import 'info_item.dart';

Widget buildLoadingHeader() {
  return Column(
    children: [
      Material(
        elevation: 10,
        borderRadius: BorderRadius.circular(90),
        child: itemLoading(150, 150, 90),
      ),
      const SizedBox(height: 20),
      itemLoading(25, 150, 5),
      const SizedBox(height: 5),
      itemLoading(20, 120, 5),
      const SizedBox(height: 10),
      OutlinedButton(
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.black,
          side: const BorderSide(color: Colors.black54),
        ),
        onPressed: null,
        child: const Text("Edit profile"),
      ),
      const SizedBox(height: 10),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          infoItem("Post", 0, () {}),
          infoItem("Followers", 0, () {}),
          infoItem("Following", 0, () {}),
        ],
      ),
      const SizedBox(height: 20),
    ],
  );
}

Widget buildLoadingBody() {
  return GridView.builder(
    shrinkWrap: true,
    padding: const EdgeInsets.symmetric(vertical: 10),
    physics: const NeverScrollableScrollPhysics(),
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3,
      childAspectRatio: 1,
      crossAxisSpacing: 3,
      mainAxisSpacing: 3,
    ),
    itemCount: 15,
    itemBuilder: (context, index) {
      return Stack(
        children: [
          itemLoading(150, 150, 0),
          Positioned(
            right: 5,
            bottom: 5,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.favorite_rounded,
                    size: 18,
                    color: Colors.red.withOpacity(0.7),
                  ),
                  const SizedBox(width: 3),
                  Text(
                    "0",
                    style: TextStyle(color: Colors.black.withOpacity(0.7)),
                  )
                ],
              ),
            ),
          )
        ],
      );
    },
  );
}
