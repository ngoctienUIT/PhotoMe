import 'dart:math';

import 'package:flutter/material.dart';

import 'message_widget.dart';

class ShowContactMessage extends StatelessWidget {
  const ShowContactMessage({Key? key, required this.check}) : super(key: key);

  final bool check;
  // final Messages messages;

  @override
  Widget build(BuildContext context) {
    return MessageWidget(
      check: check,
      child: Container(
        alignment: check ? Alignment.centerRight : Alignment.centerLeft,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          color: Colors.blue.shade400,
          child: SizedBox(
            height: 60,
            width: MediaQuery.of(context).size.width / 2,
            child: Row(
              children: [
                const Spacer(),
                Container(
                  height: 40,
                  width: 40,
                  padding: const EdgeInsets.all(5),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(90),
                    color: const Color(0xff262626),
                  ),
                  child: Center(
                    child: Text(
                      "Trần Ngọc Tiến",
                      style: TextStyle(
                        fontSize: 23,
                        color: Colors.primaries[
                            Random().nextInt(Colors.primaries.length)],
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Flexible(
                      child: Text(
                        "Trần Ngọc Tiến",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Flexible(
                      child: Text(
                        "0334161287",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
