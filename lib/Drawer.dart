import 'package:flutter/material.dart';

class ResidentDrawer extends StatelessWidget {
  const ResidentDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    return SafeArea(
      child: Container(
          child: ListTileTheme(
            textColor: Colors.white,
            iconColor: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: 128.0,
                  height: 128.0,
                  margin: const EdgeInsets.only(top: 24.0, bottom: 64.0),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: Colors.pink,
                    shape: BoxShape.circle,
                  ),
                  child: Image.network(
                      "https://cdn-icons-png.flaticon.com/800/7405/7405992.png"),
                ),
                ListTile(
                  onTap: () {Navigator.pushReplacementNamed(
                      context, "/"
                    );
                  },
                  leading: Icon(Icons.home),
                  title: Text("Home"),
                ),
                ListTile(
                  onTap: () {},
                  leading: Icon(Icons.chat_bubble_outline),
                  title: Text("Messaging & Chats"),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pushReplacementNamed(
                        context, '/complaints'
                    );
                  },
                  leading: Icon(Icons.thumb_down_off_alt_outlined),
                  title: Text("Complaints & Feedback"),
                ),
                ListTile(
                  onTap: () {},
                  leading: Icon(Icons.redeem_outlined),
                  title: Text("Couriers & Visitors"),
                ),
              ],
            ),
          )),
    );
  }
}
