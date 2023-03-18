import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({Key? key}) : super(key: key);

  String getOfflineTime(DateTime dateTime) {
    if (DateTime.now().difference(dateTime).inSeconds < 60) {
      return "${DateTime.now().difference(dateTime).inSeconds.abs()} giây trước";
    }
    if (DateTime.now().difference(dateTime).inMinutes < 60) {
      return "${DateTime.now().difference(dateTime).inMinutes.abs()} phút trước";
    }
    if (DateTime.now().difference(dateTime).inHours < 24) {
      return "${DateTime.now().difference(dateTime).inHours.abs()} giờ trước";
    }
    return "${DateTime.now().difference(dateTime).inDays.abs()} ngày trước";
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipOval(child: Image.asset("assets/images/avatar.jpg", height: 50)),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Trần Ngọc Tiến",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  // if (user.isActive)
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(90),
                    ),
                  ),
                  // if (user.isActive) const SizedBox(width: 5),
                  const SizedBox(width: 5),
                  const Expanded(
                    child: Text(
                      "Đang hoạt động",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
