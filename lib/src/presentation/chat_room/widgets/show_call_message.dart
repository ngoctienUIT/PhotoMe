import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ShowCallMessage extends StatelessWidget {
  const ShowCallMessage({Key? key, required this.check}) : super(key: key);

  final bool check;
  // final Messages messages;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: check ? Alignment.centerRight : Alignment.centerLeft,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: Colors.red.shade400,
        child: SizedBox(
          height: 60,
          width: MediaQuery.of(context).size.width / 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(90),
                  ),
                  child: const Icon(Icons.call),
                ),
              ),
              const SizedBox(width: 5),
              Flexible(
                child: Text(
                  DateFormat("HH:mm:ss").format(DateTime.now()),
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
