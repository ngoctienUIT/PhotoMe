import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_me/src/core/utils/extension/string_extension.dart';
import 'package:photo_me/src/data/model/user.dart';
import 'package:photo_me/src/presentation/search/bloc/search_bloc.dart';
import 'package:photo_me/src/presentation/search/bloc/search_state.dart';

import '../../../core/function/route_function.dart';
import '../../other_profile/screen/other_profile_page.dart';
import '../bloc/search_event.dart';
import '../widgets/search_item.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SearchBloc(), //..add(Init()),
      child: const SearchView(),
    );
  }
}

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  TextEditingController searchController = TextEditingController();
  List<User> userResults = [];

  void hm() {
    setState(() {
      userResults = users
          .where((element) => element.name.contains(searchController.text))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: false,
      //   title: const Text('Tìm kiếm'),
      //   actions: [
      //     IconButton(
      //         onPressed: () {
      //           showSearch(
      //             context: context,
      //             delegate: CustomDelegate(),
      //             query: 'asd'
      //           );
      //         },
      //         icon: const Icon(Icons.search))
      //   ],
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  // onChanged: (value) {
                  //   hm();
                  // },
                  onSubmitted: (text) {
                    // print(hm);
                    context
                        .read<SearchBloc>()
                        .add(Search(searchController.text));
                    // hm();
                  },
                  controller: searchController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: "who_are_you_looking_for".translate(context),
                  ),
                ),
              ),
              // ...userResults
              //     .map((e) => SearchItem(imgUrl: e.avatar, name: e.name)),
              BlocBuilder<SearchBloc, SearchState>(builder: (_, state) {
                if (state is SearchSuccess) {
                  return ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(8),
                    itemCount: state.users.length,
                    itemBuilder: (context, index) {
                      return SearchItem(
                        imgUrl: state.users[index].avatar,
                        name: state.users[index].name,
                        numPost: state.users[index].post?.length ?? 0,
                        navigate: () {
                          Navigator.of(context).push(createRoute(
                            screen: OtherProfilePage(id: state.users[index].id),
                            begin: const Offset(0, 1),
                          ));
                        },
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                  );
                }
                return const SizedBox();
              }),
            ],
          ),
        ),
      ),
    );
  }
}

// class CustomDelegate extends SearchDelegate {
//   @override
//   List<Widget>? buildActions(BuildContext context) {
//     return [IconButton(onPressed: () {}, icon: const Icon(Icons.clear))];
//   }
//
//   @override
//   Widget? buildLeading(BuildContext context) {
//     return IconButton(
//         onPressed: () {
//           close(context, null);
//         },
//         icon: const Icon(Icons.arrow_back));
//   }
//
//   @override
//   Widget buildResults(BuildContext context) {
//     List<User> match = users
//         .where((element) =>
//             element.name.toLowerCase().contains(query.toLowerCase()))
//         .toList();
//     return ListView.builder(
//       itemCount: match.length,
//       itemBuilder: ((context, index) {
//         return ListTile(title: Text(match[index].name));
//       }),
//     );
//   }
//
//   @override
//   Widget buildSuggestions(BuildContext context) {
//     List<User> match = users
//         .where((element) =>
//             element.name.toLowerCase().contains(query.toLowerCase()))
//         .toList();
//     return ListView.builder(
//       itemCount: match.length,
//       itemBuilder: ((context, index) {
//         return ListTile(title: Text(match[index].name));
//       }),
//     );
//   }
// }
