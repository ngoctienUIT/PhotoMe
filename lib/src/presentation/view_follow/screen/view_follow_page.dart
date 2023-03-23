import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../controls/function/route_function.dart';
import '../../other_profile/screen/other_profile_page.dart';

class ViewFollowPage extends StatefulWidget {
  const ViewFollowPage({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  State<ViewFollowPage> createState() => _ViewFollowPageState();
}

class _ViewFollowPageState extends State<ViewFollowPage>
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
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {},
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 10),
                physics: const BouncingScrollPhysics(),
                itemCount: 15,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(createRoute(
                        screen: const OtherProfilePage(),
                        begin: const Offset(1, 0),
                      ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      child: Row(
                        children: [
                          ClipOval(
                              child: Image.asset(
                            "assets/images/avatar.jpg",
                            height: 50,
                          )),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Trần Ngọc Tiến",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text("@ngoctienTNT"),
                            ],
                          ),
                          const Spacer(),
                          _followController.index == 0
                              ? OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: Colors.black,
                                    side:
                                        const BorderSide(color: Colors.black12),
                                  ),
                                  onPressed: () {},
                                  child: const Text("Đang Follow"),
                                )
                              : ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.red,
                                  ),
                                  onPressed: () {},
                                  child: const Text("Follow lại"),
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
                                  : const Icon(
                                      FontAwesomeIcons.ellipsisVertical),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
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
