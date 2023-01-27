import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gangganggang/send_letter_button.dart';
import 'package:gangganggang/src/baby_showcase_timeline_tile.dart';
import 'package:gangganggang/src/bottom_navigation.dart';
import 'package:gangganggang/src/tab_item.dart';
import 'package:gangganggang/src/tab_navigator.dart';
import 'package:gangganggang/utils/app_text_style.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timeline_tile/timeline_tile.dart';

import 'showcase_timeline.dart';

class ShowcaseTimelineTile extends StatefulWidget {
  @override
  State<ShowcaseTimelineTile> createState() => _ShowcaseTimelineTileState();
}

class _ShowcaseTimelineTileState extends State<ShowcaseTimelineTile> {
  var _currentTab = TabItem.home;

  final _navigatorKeys = {
    TabItem.favorite: GlobalKey<NavigatorState>(),
    TabItem.home: GlobalKey<NavigatorState>(),
    TabItem.grow: GlobalKey<NavigatorState>(),
  };

  void _selectTab(TabItem tabItem) {
    if (tabItem == _currentTab) {
      /// 네비게이션 탭을 누르면, 해당 네비의 첫 스크린으로 이동!
      _navigatorKeys[tabItem]!.currentState!.popUntil((route) => route.isFirst);
    } else {
      setState(() => _currentTab = tabItem);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: const [
            Color(0xff091F56),
            Color(0xff0A0E1A),
          ],
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Image(
                image: AssetImage("assets/images/background.png"),
                fit: BoxFit.contain,
                colorBlendMode: BlendMode.darken,
              ),
              Center(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: ListView.builder(
                        itemCount: examples.length,
                        itemBuilder: (BuildContext context, int index) {
                          final example = examples[index];

                          return TimelineTile(
                            alignment: TimelineAlign.start,
                            isFirst: index == 0,
                            isLast: index == examples.length - 1,
                            indicatorStyle: IndicatorStyle(
                              width: 130,
                              height: 50,
                              indicatorXY: 0.5,
                              padding:
                                  const EdgeInsets.symmetric(vertical: 0.0),
                              indicator: GestureDetector(
                                  onTap: () {
                                    _RowExample(example: example);
                                  },
                                  child: _IndicatorExample(
                                      number: '${index + 1}')),
                              drawGap: true,
                            ),
                            beforeLineStyle: LineStyle(
                              color: Colors.white.withOpacity(1),
                            ),
                            endChild: GestureDetector(
                              child: _RowExample(example: example),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute<ShowcaseTimeline>(
                                    builder: (_) =>
                                        ShowcaseTimeline(example: example),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          floatingActionButton: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.94,
                //width: 410,
                height: 198,
                child: Stack(
                  //will break to another line on overflow
                  //use vertical to show  on vertical axis
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(41, 43, 0, 0),
                        child: SizedBox(
                            height: 62,
                            width: 62,
                            child: FloatingActionButton(
                              backgroundColor: Colors.transparent,
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            BabyShowcaseTimelineTile()));
                                //action code for button 1
                              },
                              child: Image(
                                  image: AssetImage('assets/images/baby.png')),
                            )),
                      ),
                    ), //button first
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 86, 0, 0),
                        child: SizedBox(
                            height: 80,
                            width: 80,
                            child: FloatingActionButton(
                              onPressed: () {
                                _showModalBottomSheet();
                                //action code for button 2
                              },
                              backgroundColor: Color(0xff091F56),
                              child: Image(
                                  image: AssetImage(
                                      'assets/icons/icon-camera-mono.png')),
                            )),
                      ),
                    ), // button second

                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 43, 41, 0),
                        child: SizedBox(
                            height: 62,
                            width: 62,
                            child: FloatingActionButton(
                              onPressed: () {
                                //action code for button 3
                              },
                              backgroundColor: Colors.transparent,
                              child: Image(
                                  image: AssetImage('assets/images/mom.png')),
                            )),
                      ),
                    ), // button third

                    // Add more buttons here
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future _showModalBottomSheet() async {
    await showModalBottomSheet<void>(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 160,
          color: Colors.white,
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 84),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: SentLetterWidget(
                        text: '바로찍기',
                        image: 'assets/icons/camera.svg',
                        color: Color(0xffADB6C8),
                      ),
                    ),
                    const SizedBox(
                      height: 80,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: SentLetterWidget(
                        text: '사진첩',
                        image: 'assets/icons/image.svg',
                        color: Color(0xffADB6C8),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _IndicatorExample extends StatelessWidget {
  const _IndicatorExample({Key? key, required this.number}) : super(key: key);

  final String number;

  @override
  Widget build(BuildContext context) {
    return (() {
      if (number == '1') {
        return GestureDetector(
          onTap: () {},
          child: Container(
            height: 40,
            width: 40,
            decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: AssetImage('assets/emoji/emo_orange_smile.png'))),
          ),
        );
      }
      if (number == '2') {
        return Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: AssetImage('assets/emoji/emo_blue_happy.png'))),
        );
      }
      if (number == '3') {
        return Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: AssetImage(
                      'assets/emoji/emo_orange_blank_expresion.png'))),
        );
      }
      if (number == '4') {
        return Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image:
                      AssetImage('assets/emoji/emo_blue_blank_expresion.png'))),
        );
      }
      if (number == '5') {
        return Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: AssetImage('assets/emoji/emo_orange_sad.png'))),
        );
      }
      if (number == '6') {
        return Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image:
                      AssetImage('assets/emoji/emo_blue_blank_expresion.png'))),
        );
      }
      if (number == '7') {
        return Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: AssetImage('assets/emoji/emo_orange_happy.png'))),
        );
      }
      if (number == '8') {
        return Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: AssetImage('assets/emoji/emo_blue_smile.png'))),
        );
      }
      if (number == '9') {
        return Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: AssetImage('assets/emoji/emo_orange_smile.png'))),
        );
      }
      if (number == '10') {
        return Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: AssetImage('assets/emoji/emo_blue_happy.png'))),
        );
      } else {
        return Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: AssetImage('assets/emoji/emo_orange_smile.png'))),
        );
      }
    })();
  }
}

class _RowExample extends StatelessWidget {
  const _RowExample({Key? key, required this.example}) : super(key: key);

  final Example example;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            height: 50,
          ),
          Expanded(
            child: Text(example.name, style: tiny1),
          ),
          SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}
