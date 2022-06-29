// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:status_change/status_change.dart';
import 'package:steps_indicator/steps_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:winwithus/component/reuseable.dart' as prefix;
import 'package:winwithus/moreinfo/aboutapp.dart';
import 'package:winwithus/moreinfo/privacy.dart';

import 'package:winwithus/notificatins.dart';
import 'package:winwithus/onChoose.dart';
import 'package:winwithus/start.dart';

import 'component/reuseable.dart';

class Testment extends StatefulWidget {
  final playername;

  Testment(
    @required this.playername,
  );
  @override
  State<Testment> createState() => _TestmentState(playername);
}

class _TestmentState extends State<Testment> {
  //code AdMobs start
  BannerAd _bannerAd;
  bool _isAdLoaded = false;
  bool _isAdILoaded = false;
  InterstitialAd _interstitialAd;
  bool wronge = false;
  bool deO = false;
  bool sweO = false;
  bool stO = false;
  void _initAd() {
    InterstitialAd.load(
        adUnitId: 'ca-app-pub-2846772238208044/7055892543',
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
            onAdLoaded: onloaded, onAdFailedToLoad: (er) {}));
  }

  void onloaded(InterstitialAd ad) {
    _interstitialAd = ad;
    _isAdILoaded = true;
    _interstitialAd.fullScreenContentCallback =
        FullScreenContentCallback(onAdDismissedFullScreenContent: (e) {
      if (wronge) {
        Load_Qu();
      } else if (deO) {
        setState(() {
          d = 1;
          deO = false;
        });
      } else if (sweO) {
        setState(() {
          s = 1;
          sweO = false;
        });
      } else if (stO) {
        setState(() {
          a = 1;
          stO = false;
        });
      }
    });
  }

  void _initBannerAd() {
    _bannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: 'ca-app-pub-2846772238208044/1476262803',
        listener: BannerAdListener(
          onAdOpened: (l) {},
          onAdLoaded: (loaded) {
            setState(() {
              _isAdLoaded = true;
            });
          },
          onAdClicked: (c) {},
          onAdClosed: (close) {},
        ),
        request: AdRequest());
    _bannerAd.load();
  }

//code Admob end
// code sound start
  AudioCache player = AudioCache();
  AudioCache bg = AudioCache();
  Duration _duration = new Duration();
  Duration _position = new Duration();
  AudioPlayer advancedPlayer;
  AudioCache audioCache;

  void initPlayer() {
    advancedPlayer = new AudioPlayer();
    audioCache = new AudioCache(fixedPlayer: advancedPlayer);
  }

  String localFilePath;
  // code sound end

//code api start
  String insta;
  String yout;
  String face;
  int current = 0;
  int counter = 0;
  List win = ['احمد', 'لؤي', 'خالد', 'علي'];
  bool winload = false;
  int d, s, a;
  Future Load_So() async {
    String url = 'https://irbahwyana.host/api/v1/social-links';
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
          face = json['data']['facebook'].toString();
          yout = json['data']['youtube'].toString();
          insta = json['data']['instagram'].toString();
        });
      } else {
        print("failed");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  List<bool> visible = [true, true, true, true];
  String ques;
  Map<String, dynamic> aa = {
    'ans': ['', '', '', ''],
    'points': [0, 1, 0, 0]
  };
  Future Load_Qu() async {
    String url = 'https://irbahwyana.host/api/v1/questions';
    try {
      Response response = await get(
        Uri.parse(url),
        headers: {
          'Authorization':
              'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvaXJiYWh3eWFuYS5ob3N0XC9hcGlcL3YxXC9sb2dpbiIsImlhdCI6MTY1Mzk4NjU5MywibmJmIjoxNjUzOTg2NTkzLCJqdGkiOiJNWVdyY2FqbXJWREo2dERKIiwic3ViIjo0LCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.z7xfm1_grLWMnD6b9Y_mxZWVxdy45r1myYbdXEFz_4Q',
        },
      );
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body.toString());
        setState(() {
          ques = json['data']['name'];
          aa['ans'][0] = json['data']['answers'][0]['name'];
          aa['ans'][1] = json['data']['answers'][1]['name'];
          aa['ans'][2] = json['data']['answers'][2]['name'];
          aa['ans'][3] = json['data']['answers'][3]['name'];
          aa['points'][0] = int.parse(json['data']['answers'][0]['right']);
          aa['points'][1] = int.parse(json['data']['answers'][1]['right']);
          aa['points'][2] = int.parse(json['data']['answers'][2]['right']);
          aa['points'][3] = int.parse(json['data']['answers'][3]['right']);
          _start = 10;
          _initAd();
          startTimer();
          audioCache.play('timer.mp3');
          visible = [true, true, true, true];
        });
        // Questions ques = Questions.fromJson(json);
        // ans_ques();

      } else if (response.statusCode == 422) {
      } else {
        Load_Qu();
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future Load_Winner() async {
    String url = 'https://irbahwyana.host/api/v1/winners';
    try {
      Response response = await get(
        Uri.parse(url),
        headers: {
          'Authorization':
              'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvd2hhdHMteW91ci1vcmRlci5jb21cL2FwaVwvdjFcL2xvZ2luIiwiaWF0IjoxNjQ5MTcyODU5LCJuYmYiOjE2NDkxNzI4NTksImp0aSI6Ikt4czV5Unprd2dkejU2MkIiLCJzdWIiOjIwLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.KreHRgnQJ39DCjePciiFZ1R11zs_HDXMngrQPFNSLFQ',
        },
      );
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        if (json['data'] != null) {
          setState(() {
            win = json['data'] as List;
            winload = true;
          });
        }
      } else {
        print("failed");
      }
    } catch (e) {
      print(e.toString());
    }
  }
//code api end

//code timer start
  Timer _timer;
  int _start = 10;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (_timer) {
        if (_start == 0) {
          setState(() {
            advancedPlayer.stop();
            player.load('inco.mp3');
            player.play('inco.mp3');
            _timer.cancel();

            showdialogRwonge(context, 'لقد خسرت', () {
              setState(() {
                wronge = true;
                _interstitialAd.show();
              });
              current++;

              setState(() {});
            }, func2: () {
              anotherPage(context, Start());
            }, ok: "مواصلة", cancel: "اعادة اللعب");
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

//code timeer end
  @override
  void initState() {
    super.initState();
    initPlayer();
    _initBannerAd();

    _initAd();
    Load_Qu();
    Load_So();
    Load_Winner();
    a = 1;
    s = 1;
    d = 1;
  }

  @override
  void dispose() {
    advancedPlayer.stop();
    super.dispose();
  }

  //code quiz start
  void del() {
    setState(() {
      if (aa['points'][0] == 1) {
        visible[0] = true;
        visible[3] = true;
        visible[2] = false;
        visible[1] = false;
      } else {
        if (aa['points'][1] == 1) {
          visible[3] = false;
          visible[2] = true;
          visible[0] = false;
          visible[1] = true;
        } else {
          if (aa['points'][2] == 1) {
            visible[3] = true;
            visible[2] = true;
            visible[0] = false;
            visible[1] = false;
          } else {
            visible[3] = true;
            visible[2] = true;
            visible[0] = false;
            visible[1] = false;
          }
        }
      }
    });
  }

  void check(num) async {
    advancedPlayer.stop();
    if (aa['points'][num] == 1) {
      player.load('correct.mp3');
      player.play('correct.mp3');
      await showdialog(context, "أجابة صحيحة", () {
        Load_Qu();
        current++;
      });

      setState(() {
        visible = [true, true, true, true];
      });
    } else {
      player.load('inco.mp3');
      player.play('inco.mp3');
      await showdialogRwonge(
          context,
          "أجابة خاطئة",
          () {
            _timer.cancel();
            setState(() {
              wronge = true;
              advancedPlayer.stop();
            });
            _interstitialAd.show();
          },
          ok: "مواصلة",
          cancel: 'إعادة البدء',
          func2: () {
            anotherPage(context, Start());
            current++;
          });
    }
    _timer.cancel();
    if (current == 9) {
      showdialog(context, 'لقد اتممت المسابقة', () {
        anotherPage(context, Start());
      });
    }
  }

//code quiz end
  final playername;
  _TestmentState(
    this.playername,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff031a42),
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    InkWell(
                      onTap: () {
                        if (d == 1) {
                          del();
                          setState(() {
                            d = 0;
                          });
                        } else {
                          showdialogRwonge(context,
                              "لقد استخدمت هذه الميزة وقم  بمشاهدة اعلان لتفعيلها مجددا",
                              () {
                            _timer.cancel();
                            setState(() {
                              deO = true;
                            });
                            _interstitialAd.show();
                          }, ok: 'مشاهدة', cancel: 'الغاء', func2: () {});
                        }
                      },
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/percent.png',
                            width: 40,
                          ),
                          Text(
                            'حذف  إجابتين',
                            style: const TextStyle(
                                fontSize: 8, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "$d",
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    InkWell(
                      onTap: () {
                        if (s == 1) {
                          _timer.cancel();
                          Load_Qu();
                          setState(() {
                            s = 0;
                          });
                        } else {
                          showdialogRwonge(context,
                              "لقد استخدمت هذه الميزة وقم  بمشاهدة اعلان لتفعيلها مجددا",
                              () {
                            _timer.cancel();
                            setState(() {
                              sweO = true;
                            });
                            _interstitialAd.show();
                          }, ok: 'مشاهدة', cancel: 'الغاء', func2: () {});
                        }
                      },
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/switch.png',
                            width: 40,
                          ),
                          Text(
                            'تبديل السؤال',
                            style: const TextStyle(
                                fontSize: 8, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "$s",
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    InkWell(
                      onTap: () {
                        if (a == 1) {
                          advancedPlayer.stop();
                          _timer.cancel();
                          setState(() {
                            a = 0;
                          });
                        } else {
                          showdialogRwonge(context,
                              "لقد استخدمت هذه الميزة وقم  بمشاهدة اعلان لتفعيلها مجددا",
                              () {
                            _timer.cancel();
                            setState(() {
                              stO = true;
                            });
                            _interstitialAd.show();
                          }, ok: 'مشاهدة', cancel: 'الغاء', func2: () {});
                        }
                      },
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/alert.png',
                            width: 40,
                          ),
                          Text(
                            'إيقاف مؤقت',
                            style: const TextStyle(
                                fontSize: 8, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "$a",
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ]),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => Notifications()));
              },
              icon: Icon(
                Icons.notifications,
                size: 40,
                color: Colors.white,
              ))
        ],
      ),
      drawer: Container(
        padding: const EdgeInsets.only(
          top: 35,
        ),
        width: 300,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          child: Drawer(
              backgroundColor: const Color(0xff031a42),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    ' اهلا بك يا $playername',
                    textAlign: TextAlign.right,
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                  drawerRow(Icons.info, 'معلومات عن التطبيق', () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (_) => About()));
                  }),
                  drawerRow(Icons.lock, 'سياسة الخصوصية', () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (_) => Privacy()));
                  }),
                  drawerRow(Icons.logout_outlined, 'تسجيل الخروج', () {
                    // ignore: avoid_single_cascade_in_expression_statements
                    AwesomeDialog(
                      dismissOnTouchOutside: false,
                      context: context,
                      animType: AnimType.SCALE,
                      dialogType: DialogType
                          .INFO_REVERSED, // ignore: prefer_const_constructors
                      body: Center(
                        child: Text(
                          'هل انت متأكد؟',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                      title: 'This is Ignored',
                      desc: 'This is also Ignored',
                      btnCancelText: "الغاء",
                      btnCancelOnPress: () {},
                      btnCancelColor: Colors.blueAccent,
                      btnOkColor: Colors.blueAccent,
                      btnOkText: "نعم",
                      btnOkOnPress: () async {
                        bg.clearAll();
                        bg.clear(Uri.parse('bg.mp3'));
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.remove('email');
                        anotherPage(context, onChoose());
                      },
                    )..show();
                  }),
                  const SizedBox(
                      height: 30,
                      child: const Text('تواصل معنا',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18, color: Colors.white))),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                          child: iconContact('facebook'),
                          onTap: () {
                            launchUrl(Uri.parse(face));
                          }),
                      InkWell(
                          child: iconContact('youtube'),
                          onTap: () {
                            launchUrl(Uri.parse(yout));
                          }),
                      InkWell(
                          child: iconContact('instagram'),
                          onTap: () {
                            launchUrl(Uri.parse(insta));
                          }),
                    ],
                  )
                ],
              )),
        ),
      ),
      backgroundColor: const Color(0xff031a42),
      body: SafeArea(
        child: Stack(children: [
          ques == null
              ? Center(
                  child: CircularProgressIndicator(
                  color: Colors.white,
                ))
              : Column(
                  children: [
                    SizedBox(
                      child: Row(children: [
                        Expanded(child: Image.asset('assets/images/bg.png')),
                        stepper(current),
                      ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Container(
                        width: 350,
                        height: 40,
                        child: ElevatedButton(
                          child: Text("$ques"),
                          style: ElevatedButton.styleFrom(
                              shadowColor: Colors.white,
                              primary: Colors.black,
                              shape: BeveledRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)))),
                          onPressed: () {},
                        ),
                      ),
                    ),

                    // child: Button("السؤال هنا", () {}, 350.0, 60.0, visible),

                    const SizedBox(
                      height: 20,
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  answersWid(0),
                                  answersWid(1),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  answersWid(2),
                                  answersWid(3),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 55,
                          width: 80,
                          child: ElevatedButton(
                            child: Text('$_start'),
                            style: ElevatedButton.styleFrom(
                                shadowColor: Colors.blueAccent,
                                primary: Colors.black,
                                shape: BeveledRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(40)))),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                    Expanded(child: Container()),
                    SingleChildScrollView(
                        child: Column(
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(
                                win.length,
                                (index) => Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        child: winload == true
                                            ? Center(
                                                child: Text(
                                                "${win[index]}",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ))
                                            : Center(
                                                child: Text(
                                                  "${win[index]}",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                        decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        width: 130,
                                        height: 180,
                                      ),
                                    )),
                          ),
                        ),
                      ],
                    )),
                  ],
                ),
        ]),
      ),
      bottomNavigationBar: _isAdLoaded
          ? Container(
              height: _bannerAd.size.height.toDouble(),
              width: _bannerAd.size.width.toDouble(),
              child: AdWidget(ad: _bannerAd),
            )
          : SizedBox(),
    );
  }

  Container answersWid(
    num,
  ) {
    return Container(
      width: 190,
      height: 40,
      child: Visibility(
        visible: visible[num],
        child: ElevatedButton(
          child: Text('${aa['ans'][num]}'),
          style: ElevatedButton.styleFrom(
              shadowColor: Colors.blueAccent,
              primary: Colors.black,
              shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)))),
          onPressed: () {
            check(num);
          },
        ),
      ),
    );
  }

  Widget iconContact(name) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Image.asset(
        'assets/images/$name.png',
        width: 30,
      ),
    );
  }

  Widget drawerRow(icon, text, func) {
    return InkWell(
      onTap: func,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              icon,
              color: Colors.white,
              size: 30,
            ),
          ),
          Text(
            text,
            style: const TextStyle(fontSize: 20, color: Colors.white),
          )
        ],
      ),
    );
  }

  Widget winnerCon(text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Center(
            child: Text(
          text,
          style: TextStyle(color: Colors.white),
        )),
        decoration: BoxDecoration(
            color: Colors.black, borderRadius: BorderRadius.circular(20)),
        width: 130,
        height: 180,
      ),
    );
  }

  Widget buildColumn(text, name, s) {
    return InkWell(
      onTap: (() {
        if (s == 0) {
        } else if (s == 1) {
        } else {
          _timer.cancel();
        }
      }),
      child: Column(
        children: [
          Image.asset(
            'assets/images/$name.png',
            width: 40,
          ),
          Text(
            text,
            style: const TextStyle(fontSize: 8, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

_launchURL(url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

dynamic stepper(current) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: StepsIndicator(
      isHorizontal: false,
      selectedStep: current,
      selectedStepColorIn: Colors.white,
      selectedStepColorOut: Colors.white,
      nbSteps: 10,
      doneLineColor: Colors.black,
      doneStepColor: Colors.green,
      unselectedStepColorIn: Colors.white,
      undoneLineColor: Colors.black,
      lineLength: 10,
      lineLengthCustomStep: [StepsIndicatorCustomLine(nbStep: 1, length: 10)],
      enableLineAnimation: true,
      enableStepAnimation: false,
    ),
  );
}
