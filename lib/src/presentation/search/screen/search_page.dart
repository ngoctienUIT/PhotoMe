import 'package:flutter/material.dart';
import 'package:photo_me/src/data/model/user.dart';

import '../widgets/SearchItem.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();
  late List<User> userResults;
  void hm() {
    setState(() {
      userResults = users
          .where((element) => element.name.contains(searchController.text))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    hm();
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Tìm kiếm'),
        actions: [
          IconButton(
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: CustomDelegate(),
                );
              },
              icon: Icon(Icons.search))
        ],
      ),
      body: SafeArea(
        child: Column(
            // children: [
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: TextField(
            //     onChanged: (value) {
            //       hm();
            //     },
            //     controller: searchController,
            //     decoration: const InputDecoration(
            //         prefixIcon: Icon(Icons.search), border: InputBorder.none),
            //   ),
            // ),
            // ...userResults
            //     .map((e) => SearchItem(imgUrl: e.avatar, name: e.name))
            // ListView.separated(
            //   padding: const EdgeInsets.all(8),
            //   itemCount: userResults.length,
            //   itemBuilder: (BuildContext context, int index) {
            //     return Container(
            //       height: 50,
            //       width: 50,
            //     );
            //   },
            //   separatorBuilder: (BuildContext context, int index) =>
            //       const Divider(),
            // )
            // ],
            ),
      ),
    );
  }
}

class CustomDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    List<User> match = users
        .where((element) =>
            element.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
      itemCount: match.length,
      itemBuilder: ((context, index) {
        return ListTile(title: Text(match[index].name));
      }),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<User> match = users
        .where((element) =>
            element.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
      itemCount: match.length,
      itemBuilder: ((context, index) {
        return ListTile(title: Text(match[index].name));
      }),
    );
  }
}
