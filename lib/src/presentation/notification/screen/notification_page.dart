import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_me/src/domain/response/notification/notification_response.dart';
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
      listener: (_, state) {
        if (state is ReadSuccess) {
          // final notification = state.notifications.firstWhere((element) => element.id == state.id);
          // Navigator.of(context).push(createRoute(
          //   screen: ViewPostPage(post: notification.post!),
          //   begin: const Offset(0, 1),
          // ));
        }
      },
      child: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          child: Column(children: [buildBody(context)]),
        ),
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    return BlocBuilder<NotificationBloc, NotificationState>(
        builder: (_, state) {
      print(state);
      if (state is LoadingSuccess || state is ReadSuccess) {
        List<NotificationHmResponse> notifications = state is LoadingSuccess
            ? (state).notifications
            : (state as ReadSuccess).notifications;
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: notifications.length,
          itemBuilder: (_, index) {
            return Column(
              children: [
                InkWell(
                  onTap: () {
                    context.read<NotificationBloc>().add(ReadNotify(
                        notifications[index].id, notifications));
                    if (notifications[index].post != null) {
                      Navigator.of(context).push(createRoute(
                        screen: ViewPostPage(
                            post: notifications[index].post!),
                        begin: const Offset(0, 1),
                      ));
                    }
                  },
                  child: NotificationItem(
                    isRead: notifications[index].isRead,
                    imageUrl: notifications[index].toUser.avatar,
                    name: notifications[index].toUser.name,
                    postDescription:
                        notifications[index].post?.description ?? "",
                    action: notifications[index].text,
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
