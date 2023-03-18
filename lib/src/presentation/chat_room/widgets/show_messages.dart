import 'package:flutter/material.dart';

import 'show_audio_message.dart';
import 'show_call_message.dart';
import 'show_contact_message.dart';
import 'show_delete_message.dart';
import 'show_file_message.dart';
import 'show_text_message.dart';

class ShowMessages extends StatelessWidget {
  const ShowMessages({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {},
      child: ListView.builder(
        shrinkWrap: true,
        reverse: true,
        physics: const BouncingScrollPhysics(),
        itemCount: 10,
        itemBuilder: (context, index) {
          // if (!messages[index].delete) {
          if (true) {
            switch (5) {
              case 0:
                return const ShowCallMessage(check: true);
              case 1:
                return const ShowFileMessage(check: true);
              case 2:
              // return ShowImageMessage(check: true);
              case 3:
                return const ShowAudioMessage(check: true);
              case 4:
                break;
              case 5:
                return const ShowTextMessage(check: true);
              case 6:
                return const ShowContactMessage(check: true);
              default:
                return Container();
            }
          }
          return const ShowDeleteMessage(check: true);
        },
      ),
    );
  }
}
