import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart';
import 'package:gsa/modal/dbsync.dart';
import 'package:gsa/modal/storyLanguage.dart';

class InitPage extends StatefulWidget {
  const InitPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<InitPage> createState() => _InitPageState();
}

class _InitPageState extends State<InitPage> {
  DBSync dbsobj = DBSync();

  String loadingString = "";
  int steps = 0;
  bool enablebutton = false;
  bool loadingdata = true;

  @override
  void initState() {
    print("init homepage");
    dbsobj.getLastInsertedData("story_content").then((value) {
      int lastno = value[0]["id"];
      if (lastno == 0) {
        getSyncLocalData().whenComplete(() {
          setState(() {
            enablebutton = true;
            loadingdata = false;
          });
          print("All Done");
          moveToMainScreen();
        });
      } else {
        print("All Done $lastno");
        moveToMainScreen();
      }
    });

    super.initState();
  }

  moveToMainScreen() {
    Navigator.pushNamedAndRemoveUntil(
        context, 'home', ModalRoute.withName('home'));
  }

  Future getSyncLocalData() async {
    await dbsobj.syncStoryLanguage(
        (percent) => {setPercentData("Loading Language $percent%")});
    await dbsobj.syncStoryImages(
        (percent) => {setPercentData("Loading Story Images $percent%")});
    await dbsobj.syncStoryContent(
        (percent) => {setPercentData("Loading Stories $percent%")});
  }

  setPercentData(String message) {
    print(message);
    setState(() {
      loadingString = message;
    });
  }

  final imgList = [
    {
      "img":
          'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
      'description': 'dfsfsfsfsf sfdsfsf dfsfs'
    },
    {
      "img":
          'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
      'description': 'oooooooooooo'
    },
    {
      "img":
          'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
      'description': 'ddddddddddd'
    },
    {
      "img":
          'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
      'description': 'ttttttttttttt'
    },
    {
      "img":
          'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
      'description': 'uuuuuuuuuuuuuuu'
    },
    {
      "img":
          'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
      'description': 'oooooooooooooo'
    },
    {
      "img":
          'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80',
      'description': 'xxxxxxxxxxxxxxxxx'
    },
  ];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Builder(
        builder: (context) {
          final double height = MediaQuery.of(context).size.height;
          return Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                loadingdata
                    ? CircularProgressIndicator()
                    : SizedBox(
                        height: 0,
                      ),
                Container(
                  child: Text(loadingString),
                ),
                SizedBox(
                  height: 10,
                ),
                Directionality(
                    textDirection: TextDirection.rtl,
                    child: ElevatedButton.icon(
                        onPressed: enablebutton ? () => {} : null,
                        icon: Icon(
                          Icons.arrow_back,
                          size: 15,
                        ),
                        label: Text("Continue")))
              ],
            ),
          );
        },
      ),
    );
  }
}
