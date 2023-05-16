import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:photo_me/src/presentation/view_follow/bloc/view_follow_bloc.dart';
import 'package:photo_me/src/presentation/view_follow/bloc/view_follow_event.dart';
import 'package:photo_me/src/presentation/view_follow/bloc/view_follow_state.dart';

import '../../../core/function/route_function.dart';
import '../../other_profile/screen/other_profile_page.dart';

class ViewFollowPage extends StatelessWidget {
  const ViewFollowPage({Key? key, required this.index, required this.id})
      : super(key: key);
  final int index;
  final String id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ViewFollowBloc()..add(FetchData(id)),
      child: ViewFollowView(index: index, id: id),
    );
  }
}

class ViewFollowView extends StatefulWidget {
  const ViewFollowView({Key? key, required this.index, required this.id})
      : super(key: key);
  final int index;
  final String id;

  @override
  State<ViewFollowView> createState() => _ViewFollowViewState();
}

class _ViewFollowViewState extends State<ViewFollowView>
    with TickerProviderStateMixin {
  late TabController _followController;

  @override
  void initState() {
    _followController =
        TabController(length: 2, vsync: this, initialIndex: widget.index);
    _followController.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Trần Ngọc Tiến"), elevation: 0),
      body: Column(
        children: [
          SizedBox(
            height: 50,
            child: TabBar(
              controller: _followController,
              isScrollable: false,
              labelColor: Colors.black87,
              labelStyle:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              unselectedLabelColor: const Color.fromRGBO(45, 216, 198, 1),
              unselectedLabelStyle: const TextStyle(fontSize: 16),
              indicatorColor: Colors.green,
              tabs: const [Tab(text: "Follower"), Tab(text: "Following")],
            ),
          ),
          Expanded(child: buildBody()),
        ],
      ),
    );
  }

  Widget buildBody() {
    return BlocBuilder<ViewFollowBloc, ViewFollowState>(builder: (_, state) {
      print(state);
      if (state is ViewFollowLoaded) {
        final list =
            _followController.index == 0 ? state.follower : state.following;
        return RefreshIndicator(
          onRefresh: () async {
            context.read<ViewFollowBloc>().add(FetchData(widget.id));
          },
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 10),
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            itemCount: list.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(createRoute(
                    screen: OtherProfilePage(id: list[index].id),
                    begin: const Offset(1, 0),
                  ));
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Row(
                    children: [
                      ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: list[index].avatar,
                          height: 50,
                          width: 50,
                          placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                          errorWidget: (context, url, error) => Image.asset(
                            "assets/images/avatar.jpg",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            list[index].name,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          const Text("@ngoctienTNT"),
                        ],
                      ),
                      const Spacer(),
                      _followController.index == 0
                          ? ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.red,
                              ),
                              onPressed: () {
                                print(list[index].id);
                                context
                                    .read<ViewFollowBloc>()
                                    .add(FollowEvent(list[index].id));
                              },
                              child: const Text("Follow lại"),
                            )
                          : OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.black,
                                side: const BorderSide(color: Colors.black12),
                              ),
                              onPressed: () {
                                print(list[index].id);
                                context
                                    .read<ViewFollowBloc>()
                                    .add(FollowEvent(list[index].id));
                              },
                              child: const Text("Đang Follow"),
                            ),
                      const SizedBox(width: 5),
                      InkWell(
                        onTap: () {
                          if (_followController.index == 1) {
                            _showActionDialog(context);
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: _followController.index == 0
                              ? const Icon(Icons.notifications)
                              : const Icon(FontAwesomeIcons.ellipsisVertical),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }
      return const Center(child: CircularProgressIndicator());
    });
  }

  Future _showActionDialog(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            children: [
              SimpleDialogOption(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Loại bỏ follower này',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Hủy',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          );
        });
  }
}
