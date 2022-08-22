import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:gsa/modal/dbsync.dart';
import 'package:gsa/modal/curd.dart';
import 'package:flutter_html/flutter_html.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DBSync dbsobj = DBSync();
  Dbconnect db = Dbconnect();

  String loadingString = "";
  int steps = 0;
  List storyline = [];
  CarouselController buttonCarouselController = CarouselController();

  @override
  void initState() {
    print("init homepage");
    getSyncLocalData();
    super.initState();
  }

  Future getSyncLocalData() async {
    List res_story = await db.getContentByLanguage("2");
    print(res_story);
    setState(() {
      storyline = res_story;
    });
  }

  setPercentData(String message) {
    print(message);
    setState(() {
      loadingString = message;
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [],
      ),
      floatingActionButton: const FloatingActionButton(
        tooltip: 'Add', // used by assistive technologies
        onPressed: null,
        child: Icon(Icons.translate),
      ),
      body: Builder(
        builder: (context) {
          final double height = MediaQuery.of(context).size.height;
          return CarouselSlider(
            carouselController: buttonCarouselController,
            options: CarouselOptions(
                height: height,
                viewportFraction: 1.0,
                enlargeCenterPage: false,
                onPageChanged: (int index, pagereason) {
                  print(storyline[index]);
                  //Downloading images
                }
                // autoPlay: false,
                ),
            items: storyline
                .map((item) => SingleChildScrollView(
                        child: Column(children: [
                      Center(
                          child: Image.network(
                        item['image'].toString(),
                        fit: BoxFit.cover,
                        // height: height,
                      )),
                      Container(
                          child: Html(
                        data: """${item['content']}""",
                      ))
                    ])))
                .toList(),
          );
        },
      ),
    );
  }
}
