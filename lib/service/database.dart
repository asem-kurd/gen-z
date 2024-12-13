import 'package:flutter_application_99/taple_firebase/organstion_list.dart';
import 'package:flutter_application_99/view_model/org_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// ignore: camel_case_types
class organisationdatasbaseservice {
  organisationdatasbaseservice._();
  static final organisationdatasbaseservice db =
      organisationdatasbaseservice._();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDb();
    return _database!;
  }

  Future<Database> initDb() async {
    String path = join(await getDatabasesPath(), "organisation.db");

    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
        CREATE TABLE $tapleOrganisation (
          $avaterOrganisation TEXT NOT NULL,
          $nameOrganisation TEXT NOT NULL,
          $phoneOrganisation INTEGER NOT NULL,
          $urlOrganisation INTEGER NOT NULL
        )
        ''');
      },
    );
  }

  Future<void> insert(Firestoreorg model) async {
    var dbClient = await database;
    await dbClient.insert(
      tapleOrganisation,
      model.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
