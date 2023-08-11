import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sql.dart';

class SQLhelper {
  static Future<void> createtables(sql.Database db) async {
    await db.execute("CREATE TABLE Cred(USERNAME TEXT PRIMARY KEY,PASSWORD TEXT )");
    await db.execute("CREATE TABLE Data(USERNAME TEXT PRIMARY KEY, T_CAL DOUBLE , BF_P DOUBLE , CARB DOUBLE, PROTEIN DOUBLE , FAT DOUBLE , TDEE DOUBLE, BMI DOUBLE )");
    await db.execute("CREATE TABLE UserDetail(USERNAME TEXT PRIMARY KEY,GENDER TEXT,DOB TEXT,ACTLVL TEXT,GOAL TEXT)");
  }

  static Future<sql.Database> db() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = '${directory.path}Db.db';
    return sql.openDatabase(path,version:1,onCreate: (sql.Database database,int version) async{
      await SQLhelper.createtables(database);
    });
  }

  static Future<bool> ifexists(String uname) async{
    final dbase = await SQLhelper.db();
    var a = await dbase.rawQuery('select count(*) from Data where username = ?',[uname]);
    if(a[0]['count(*)'] == 0 ){
      return false;
    }
    return true;
  }

  static Future<List<Map<String,dynamic>>> fetchdata(String uname) async{
    final dbase = await SQLhelper.db();
    return dbase.rawQuery('select * from Data where username = ?',[uname]);
  }

  static Future<List<Map<String,dynamic>>> fetchrecord(String uname) async{
    final dbase = await SQLhelper.db();
    return dbase.rawQuery('select * from $uname');
  }

  static Future<List<Map<String,dynamic>>> fetchdetail(String uname) async{
    final dbase = await SQLhelper.db();
    return dbase.rawQuery('select * from UserDetail where username = ?',[uname]);
  }

  static Future<int> insertdata(String username,double tCal,double bfp,double carb,double protein,double fats,double tdee,double bmi,String gender,String bmiscale) async{
    final dbase = await SQLhelper.db();
    final Map<String,dynamic> data;
    await dbase.execute("CREATE TABLE IF NOT EXISTS Data(USERNAME TEXT PRIMARY KEY, T_CAL DOUBLE , BF_P DOUBLE , CARB DOUBLE, PROTEIN DOUBLE , FAT DOUBLE , TDEE DOUBLE, BMI DOUBLE, B_SCALE TEXT )");
    data = {'USERNAME':username ,'T_CAL':tCal ,'BF_P':bfp ,'CARB':carb ,'PROTEIN':protein ,'FAT':fats ,'TDEE':tdee ,'BMI':bmi,'B_SCALE':bmiscale} ;
    final id  = await dbase.insert('Data',data,conflictAlgorithm:sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<int> insertdetail(String username,String gender,int dob,String actlvl,String goal) async{
    final dbase = await SQLhelper.db();
    await dbase.execute("CREATE TABLE IF NOT EXISTS UserDetail(USERNAME TEXT PRIMARY KEY,GENDER TEXT,DOB INT,ACTLVL TEXT,GOAL TEXT)");
    final data = {'USERNAME':username,'GENDER':gender,'DOB':dob,'ACTLVL':actlvl,'GOAL':goal};
    final id  = await dbase.insert('UserDetail',data,conflictAlgorithm:ConflictAlgorithm.replace);
    return id;
  }

  static Future<int> insertrecord(String username , double weight ,double height, double bfp, String date, String gender,Map<String,dynamic> measurement) async{
    final dbase = await SQLhelper.db();
    if(gender == 'male'){
      await dbase.execute("CREATE TABLE IF NOT EXISTS $username(WEIGHT DOUBLE,HEIGHT DOUBLE,BF_P DOUBLE,WAIST DOUBLE,NECK DOUBLE,DATE TEXT PRIMARY KEY)");
      final data = {'WEIGHT':weight,'HEIGHT':height,'BF_P':bfp,'WAIST':measurement['waist'],'NECK':measurement['neck'],'DATE': date};
      final id  = await dbase.insert(username,data,conflictAlgorithm:ConflictAlgorithm.replace);
      return id;
    }
    else{
      await dbase.execute("CREATE TABLE IF NOT EXISTS $username(WEIGHT DOUBLE,BF_P DOUBLE,WAIST DOUBLE,NECK DOUBLE,HIP DOUBLE, DATE TEXT PRIMARY KEY)");
      final data = {'WEIGHT':weight,'BF_P':bfp,'WAIST':measurement['waist'],'NECK':measurement['neck'],'HIP':measurement['hip'],'DATE': date};
      final id  = await dbase.insert(username,data,conflictAlgorithm:ConflictAlgorithm.replace);
      return id;
    }
  }

  static Future<int> createitem(String username,String pass) async{
    final dbase = await SQLhelper.db();
    final data = {'USERNAME':username ,'PASSWORD':pass};
    final id  = await dbase.insert('Cred',data,conflictAlgorithm:sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String,dynamic>>> getitem() async{
    final dbase = await SQLhelper.db();
    return dbase.query('Cred');
  }
}

