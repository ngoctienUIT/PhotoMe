import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../widgets/bottom_sheet_file.dart';
import '../widgets/select_emoji.dart';
import '../widgets/show_messages.dart';
import '../widgets/title_chat.dart';

class ChatRoomPage extends StatefulWidget {
  const ChatRoomPage({Key? key}) : super(key: key);

  @override
  State<ChatRoomPage> createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  final TextEditingController _controller = TextEditingController();
  FocusNode focusNode = FocusNode();
  bool show = false;
  bool sendButton = false;
  File? audio;
  late FlutterSoundRecorder recorder = FlutterSoundRecorder();

  @override
  void initState() {
    initRecorder();
    super.initState();

    _controller.addListener(() {
      setState(() {
        if (_controller.text.isNotEmpty) {
          sendButton = true;
        } else {
          sendButton = false;
        }
      });
    });
  }

  Future initRecorder() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw 'error';
    }
    await recorder.openRecorder();
    recorder.setSubscriptionDuration(const Duration(milliseconds: 500));
  }

  Future stop() async {
    final path = await recorder.stopRecorder();
    audio = File(path!);
    setState(() {});
  }

  Future record() async {
    await recorder.startRecorder(toFile: 'audio');
    setState(() {});
  }

  @override
  void dispose() {
    recorder.closeRecorder();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: TitleChat(),
      ),
      body: WillPopScope(
        onWillPop: () {
          if (show) {
            setState(() => show = false);
          } else {
            Navigator.pop(context);
          }
          return Future.value(false);
        },
        child: Column(
          children: [
            const SizedBox(height: 10),
            const Expanded(child: ShowMessages(id: "id")),
            const SizedBox(height: 10),
            bottomInput(),
            Expanded(
              flex: show ? 1 : 0,
              child: show ? emojiSelect(_controller) : const SizedBox.shrink(),
            )
          ],
        ),
      ),
    );
  }

  Widget bottomInput() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width - 60,
                child: Card(
                  margin: const EdgeInsets.only(left: 2, right: 2, bottom: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: TextFormField(
                    controller: _controller,
                    focusNode: focusNode,
                    textAlignVertical: TextAlignVertical.center,
                    keyboardType: TextInputType.multiline,
                    minLines: 1,
                    maxLength: null,
                    maxLines: null,
                    onTap: () {
                      if (show) {
                        setState(() => show = !show);
                      }
                    },
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        setState(() => sendButton = true);
                      } else {
                        setState(() => sendButton = false);
                      }
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Type a message",
                      hintStyle: const TextStyle(color: Colors.grey),
                      prefixIcon: IconButton(
                        icon: Icon(
                          show ? Icons.keyboard : Icons.emoji_emotions_outlined,
                        ),
                        onPressed: () {
                          if (!show) {
                            focusNode.unfocus();
                            focusNode.canRequestFocus = false;
                          } else {
                            focusNode.requestFocus();
                          }
                          setState(() => show = !show);
                        },
                      ),
                      suffixIcon: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.attach_file),
                            onPressed: () {
                              showModalBottomSheet(
                                backgroundColor: Colors.transparent,
                                context: context,
                                builder: (builder) => const BottomSheetFile(),
                              );
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.camera_alt),
                            onPressed: () async {
                              try {
                                final image = await ImagePicker()
                                    .pickImage(source: ImageSource.camera);
                                if (image != null) {
                                  image.path.split('.').last;
                                }
                              } on PlatformException catch (_) {}
                            },
                          ),
                        ],
                      ),
                      contentPadding: const EdgeInsets.all(5),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 8,
                  right: 2,
                  left: 2,
                ),
                child: CircleAvatar(
                  radius: 25,
                  backgroundColor: const Color(0xFF128C7E),
                  child: IconButton(
                    icon: Icon(
                      sendButton
                          ? Icons.send
                          : (recorder.isRecording ? Icons.stop : Icons.mic),
                      color: Colors.white,
                    ),
                    onPressed: () async {
                      if (sendButton) {
                        _controller.text = "";
                      } else if (recorder.isRecording) {
                        await stop();
                        // audio;
                      } else {
                        record();
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
