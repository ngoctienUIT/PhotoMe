import 'package:flutter/material.dart';

import 'message_widget.dart';

class ShowInfoReaction extends StatefulWidget {
  const ShowInfoReaction({Key? key}) : super(key: key);

  // final Messages messages;

  @override
  State<ShowInfoReaction> createState() => _ShowInfoReactionState();
}

class _ShowInfoReactionState extends State<ShowInfoReaction>
    with TickerProviderStateMixin {
  late TabController tabController;
  late List<dynamic> listReact;

  @override
  void initState() {
    listReact = ["❤", "😯"];
    tabController = TabController(length: listReact.length + 1, vsync: this);
    tabController.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      margin: const EdgeInsets.fromLTRB(10, 0, 10, 20),
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                "Cảm xúc",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
              )
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                if (tabController.index == 0 ||
                    react[1] == listReact[tabController.index - 1]) {
                  return showUser(index);
                }
                return const SizedBox.shrink();
              },
            ),
          ),
          Container(
            height: 40,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TabBar(
              controller: tabController,
              labelColor: Colors.black87,
              labelStyle:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              unselectedLabelColor: const Color.fromRGBO(45, 216, 198, 1),
              unselectedLabelStyle:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              isScrollable: true,
              indicatorColor: Colors.red,
              indicator: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(10),
              ),
              tabs: [
                const Tab(text: "All"),
                ...List.generate(
                  listReact.length,
                  (index) => Tab(text: react[listReact[index]]),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget showUser(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          ClipOval(child: Image.asset("assets/images/avatar.jpg")),
          const SizedBox(width: 10),
          const Text(
            "Trần Ngọc Tiến",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          Text(react[1], style: const TextStyle(fontSize: 20)),
        ],
      ),
    );
  }
}
