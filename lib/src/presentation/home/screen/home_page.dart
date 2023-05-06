import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_me/src/presentation/home/bloc/home_bloc.dart';
import 'package:photo_me/src/presentation/home/bloc/home_state.dart';
import 'package:photo_me/src/presentation/new_post/screen/new_post_page.dart';

import '../../../core/function/route_function.dart';
import '../../post_item/post_item.dart';
import '../bloc/home_event.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc()..add(FetchData()),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        title: const Text(
          "PhotoMe",
          style: TextStyle(
            fontSize: 23,
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
        // actions: [
        //   InkWell(
        //     onTap: () {
        //       Navigator.of(context).push(createRoute(
        //         screen: const MessagePage(),
        //         begin: const Offset(1, 0),
        //       ));
        //     },
        //     child: const Padding(
        //       padding: EdgeInsets.symmetric(horizontal: 15),
        //       child: Icon(FontAwesomeIcons.paperPlane),
        //     ),
        //   ),
        // ],
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            context.read<HomeBloc>().add(FetchData());
          },
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            child: Column(
              children: [buildHeader(context), buildBody()],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      decoration: BoxDecoration(
        color: const Color(0xFFE1E1E1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          ClipOval(
            child: Image.asset(
              "assets/images/avatar.jpg",
              height: 50,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              readOnly: true,
              decoration: const InputDecoration(
                hintText: "Bạn đang nghĩ gì?",
                border: InputBorder.none,
              ),
              onTap: () {
                Navigator.of(context).push(createRoute(
                  screen: const NewPostPage(),
                  begin: const Offset(0, 1),
                ));
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBody() {
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      print(state);
      if (state is HomeLoaded) {
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: state.post.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                const SizedBox(height: 20),
                PostItem(post: state.post[index], checkViewPost: false),
              ],
            );
          },
        );
      }
      return const Center(child: CircularProgressIndicator());
    });
  }

  @override
  bool get wantKeepAlive => true;
}
