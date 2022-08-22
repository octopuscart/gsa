import 'package:sqflite/sqflite.dart';

class Dbconnect {
  Database? db;

  Dbconnect() {
    initializeDB();
  }

  //static Database? _database;

  Future<Database> initializeDB() async {
    return await openDatabase('hod10.db', version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute('''CREATE TABLE story_language (
            id INTEGER PRIMARY KEY,
            server_id INTEGER,
            title CHAR(100),
            display_index INTEGER,
            is_default  CHAR(10) ,
            is_active INTEGER)''');

      await db.execute('''CREATE TABLE story_images (
            id INTEGER PRIMARY KEY,
             server_id INTEGER,
            image CHAR(100),
            display_index INTEGER,
            timestamp CHAR(10),
            local_path CHAR(510))''');

      await db.execute('''CREATE TABLE story_content (
            id INTEGER PRIMARY KEY,
             server_id INTEGER,
            image_id CHAR(50),
            language_id CHAR(50),
            display_index INTEGER,
            content  TEXT)''');
    });
  }

  Future<List> getContentByLanguage2(String language_id) async {
    List<Map<String, dynamic>> maps = await db!.rawQuery(
        'SELECT * FROM favourite_song where song_id = ?  order by id',
        [language_id]);
    if (maps.isEmpty) {
      print("no data");
      return [];
    } else {
      return maps;
    }
  }

  Future<List> getContentByLanguage(String language_id) async {
    final Database db = await initializeDB();
    List<Map<String, dynamic>> maps = await db.rawQuery(
        """ SELECT si.id, si.image, si.display_index, sc.content, si.local_path FROM story_images as si 
     join story_content as sc on sc.image_id = si.server_id
   where sc.language_id = ? 
   order by si.display_index asc""", [language_id]);
    if (maps.isEmpty) {
      print("no data");
      return [];
    } else {
      return maps;
    }
  }

  Future<int> insertData(tablename, insertDataObject) async {
    final Database db = await initializeDB();
    int id2 = await db.insert(tablename, insertDataObject.toMap());
    return id2;
  }

  Future<List> getDataByQuery(String query) async {
    final Database db = await initializeDB();
    List<Map<String, dynamic>> maps = await db.rawQuery(query);
    if (maps.isEmpty) {
      print("no data");
      return [
        {"id": 0}
      ];
    } else {
      return maps;
    }
  }
}
