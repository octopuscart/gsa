import 'curd.dart';
import 'config.dart';
import 'storyLanguage.dart';
import 'storyContent.dart';
import 'storyImages.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class DBSync {
  Dbconnect db = Dbconnect();
  DBSync() {
    // Dbconnect db = Dbconnect();
  }

  Future getDataFromServer(url_sufix) async {
    final http.Response response =
        await http.get(Uri.parse('$apiendpoint/$url_sufix'));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
      return (parsed);
      // List returndata = parsed.map((json) => Type.fromJson(json)).toList();
      // print(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<int> insertScriptureData(
      datalist, tablename, int index, callback) async {
    if (datalist.length > index) {
      var singledata = datalist[index];
      await db.insertData(tablename, singledata);
      int perdata = datalist.length;
      int progesspercent = ((index * 100) / perdata).round();
      callback(progesspercent);
      var percent = ((index * 100) / perdata).round();
      await insertScriptureData(datalist, tablename, index + 1, callback);
      return index + 1;
    } else {
      callback(100);
      return 100;
    }
    return index + 1;
  }

  Future<int> syncStoryLanguage(callback) async {
    Map story_language = {
      'api': 'getLanguage',
      'title': "Story Language",
      "table_name": "story_language",
    };
    List story_languageData = await getDataFromServer(story_language["api"]);
    List story_languageDataParsed =
        story_languageData.map((json) => StoryLanguage.fromJson(json)).toList();
    return await insertScriptureData(
        story_languageDataParsed, story_language["table_name"], 0, callback);
  }

  Future<int> syncStoryImages(callback) async {
    Map story_language = {
      'api': 'getImageData',
      'title': "Story Images",
      "table_name": "story_images",
    };
    List story_languageData = await getDataFromServer(story_language["api"]);
    List story_languageDataParsed =
        story_languageData.map((json) => StoryImages.fromJson(json)).toList();
    await insertScriptureData(
        story_languageDataParsed, story_language["table_name"], 0, callback);
    return 200;
  }

  Future<int> syncStoryContent(callback) async {
    Map story_language = {
      'api': 'getContent',
      'title': "Stories",
      "table_name": "story_content",
    };
    List story_languageData = await getDataFromServer(story_language["api"]);
    List story_languageDataParsed =
        story_languageData.map((json) => StoryContent.fromJson(json)).toList();
    await insertScriptureData(
        story_languageDataParsed, story_language["table_name"], 0, callback);
    return 200;
  }

  Future getDataAndInsert(callback) async {
    await syncStoryLanguage(
        (percent) => {callback("Loading Language $percent%")});
    await syncStoryImages(
        (percent) => {callback("Loading Story Images $percent%")});
    await syncStoryContent(
        (percent) => {callback("Loading Stories $percent%")});
  }

  Future getLastInsertedData(String tablename) async {
    return db.getDataByQuery(
        "select id from  $tablename order by id desc limit 0,1");
  }
}
