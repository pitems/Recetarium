import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
class DBHelper{

static final DBHelper _singleton=DBHelper._();
static DBHelper get instance => _singleton;
Completer <Database> dbopencompleter;
DBHelper ._();

//retorno y Creacion DB
Future<Database> get db async {
  if(dbopencompleter==null){
    dbopencompleter=Completer();
    await _openDB();
    
  }
  return dbopencompleter.future;
}

//Creacion de DB
Future _openDB()async {
  final dir = await getApplicationDocumentsDirectory();
  final dbpath =join(dir.path,"Ledb.db");
  final database = await databaseFactoryIo.openDatabase(dbpath);

  dbopencompleter.complete(database); 
}

}