import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:photo_me/src/core/utils/extension/string_extension.dart';

class PolicyPage extends StatefulWidget {
  const PolicyPage({Key? key}) : super(key: key);

  @override
  State<PolicyPage> createState() => _PolicyPageState();
}

class _PolicyPageState extends State<PolicyPage> {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0, title: Text("policy".translate(context))),
      body: Stack(
        children: [
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : const SizedBox(),
          InAppWebView(
            onLoadStop: (controller, url) {
              setState(() => isLoading = false);
            },
            initialUrlRequest: URLRequest(
                url: Uri.parse(
                    "https://www.tiktok.com/legal/page/row/terms-of-service/vi-VN")),
          ),
        ],
      ),
    );
  }
}
