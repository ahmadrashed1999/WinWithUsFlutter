import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  List text = [1, 2, 4];
  bool load = false;
  @override
  void initState() {
    super.initState();
    Load_Qu();
  }

  Future Load_Qu() async {
    String url = 'https://irbahwyana.host/api/v1/my-notifications';
    try {
      Response response = await get(
        Uri.parse(url),
        headers: {
          'Authorization':
              'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvd2hhdHMteW91ci1vcmRlci5jb21cL2FwaVwvdjFcL2xvZ2luIiwiaWF0IjoxNjQ5MTcyODU5LCJuYmYiOjE2NDkxNzI4NTksImp0aSI6Ikt4czV5Unprd2dkejU2MkIiLCJzdWIiOjIwLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.KreHRgnQJ39DCjePciiFZ1R11zs_HDXMngrQPFNSLFQ',
        },
      );
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body.toString());
        setState(() {
          text = json['data']['data'];
          load = true;
        });

        print(json['data']);
      } else {
        print("failed");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('الإشعارات'),
        backgroundColor: const Color(0xff031a42),
        elevation: 0,
        centerTitle: true,
        backwardsCompatibility: true,
      ),
      backgroundColor: const Color(0xff031a42),
      body: SafeArea(
          child: load == true
              ? ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: text.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            leading: Icon(Icons.notifications, size: 45),
                            title: Text('${text[index]['title']}'),
                            subtitle: Text('${text[index]['details']}'),
                          ),
                        ],
                      ),
                    );
                    // return Container(
                    //   height: 50,
                    //   color: Colors.white,
                    //   child: Center(child: Text('${text[index]['details']}')),
                    // );
                  })
              : Container(
                  child: Center(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.notifications_none_sharp,
                        size: 50,
                        color: Colors.white,
                      ),
                      Text(
                        'لا يوجد اشعارات بعد',
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                    ],
                  )),
                )),
    );
  }
}
