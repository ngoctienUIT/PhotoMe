import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_me/src/presentation/notification/bloc/notification_bloc.dart';
import 'package:photo_me/src/presentation/notification/bloc/notification_state.dart';
import 'package:photo_me/src/presentation/notification/widgets/notification_item.dart';

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
                NotificationItem(
                  imageUrl: "assets/images/avatar.jpg",
                  name: state.notifications[index].toUser.name,
                  action: state.notifications[index].text,
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
