import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:photo_me/src/core/widgets/item_loading.dart';
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
  ScrollController controller = ScrollController();
  bool isVisible = false;

  @override
  void initState() {
    controller.addListener(() {
      if (isVisible != (controller.position.pixels > 100)) {
        setState(() {
          isVisible = controller.position.pixels > 100;
        });
      }
      // print(controller.position.pixels);
    });
    super.initState();
  }

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
            controller: controller,
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            child: Column(
              children: [buildHeader(context), buildBody()],
            ),
          ),
        ),
      ),
      floatingActionButton: Visibility(
        visible: isVisible,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(createRoute(
              screen: const NewPostPage(),
              begin: const Offset(0, 1),
            ));
          },
          child: const Icon(Icons.add),
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
    return BlocBuilder<HomeBloc, HomeState>(builder: (_, state) {
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
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 10,
        itemBuilder: (context, index) {
          return Column(
            children: [
              const SizedBox(height: 20),
              itemPostLoading(),
            ],
          );
        },
      );
    });
  }

  Widget itemPostLoading() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const SizedBox(width: 5),
              itemLoading(50, 50, 90),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  itemLoading(20, 120, 5),
                  const SizedBox(height: 5),
                  itemLoading(20, 60, 5),
                ],
              ),
            ],
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: itemLoading(20, 120, 5),
          ),
          const SizedBox(height: 5),
          itemLoading(
            MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.width,
            0,
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  itemLoadingWidget(const Icon(Icons.favorite_border_rounded)),
                  const SizedBox(width: 5),
                  itemLoading(20, 30, 5),
                ],
              ),
              Row(
                children: [
                  itemLoadingWidget(const Icon(FontAwesomeIcons.comment)),
                  const SizedBox(width: 5),
                  itemLoading(20, 30, 5),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
