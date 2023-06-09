import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_me/src/presentation/notification/bloc/notification_bloc.dart';
import 'package:photo_me/src/presentation/notification/bloc/notification_state.dart';
import 'package:photo_me/src/presentation/notification/widgets/notification_item.dart';

import '../../../core/function/route_function.dart';
import '../../view_post/screen/view_post_page.dart';
import '../bloc/notification_event.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => NotificationBloc()..add(Init()),
      child: const NotificationView(),
    );
  }
}

class NotificationView extends StatelessWidget {
  const NotificationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<NotificationBloc, NotificationState>(
      listener: (_, state) {},
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        child: Column(
          children: [buildBody()],
        ),
      ),
    );
  }

  Widget buildBody() {
    return BlocBuilder<NotificationBloc, NotificationState>(
        builder: (_, state) {
      print(state);
      if (state is LoadingSuccess) {
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: state.notifications.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                const SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    if(state.notifications[index].post != null){
                      Navigator.of(context).push(createRoute(
                        screen: ViewPostPage(post: state.notifications[index].post!),
                        begin: const Offset(0, 1),
                      ));
                    }

                  },
                  child: NotificationItem(
                    imageUrl: state.notifications[index].toUser.avatar,
                    name: state.notifications[index].toUser.name,
                    action: state.notifications[index].text,
                  ),
                ),
              ],
            );
          },
        );
      }
      return const Center(child: CircularProgressIndicator());
    });
  }
}
