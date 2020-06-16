import 'package:recetarium/DB/Receta/recetamodel.dart';
import 'package:recetarium/DB/db.dart';
import 'package:sembast/sembast.dart';

class RecetaCollection {
  static String receta = "recetas";
  final _huertocollection = intMapStoreFactory.store(receta);

  Future<Database> get _db async => await DBHelper.instance.db;

//Metodos future esperando que se completen

//INSERT
  Future insert(Recetas modelo) async {
    await _huertocollection.add(await _db, modelo.toMap());
  }

//UPDATE
  Future update(Recetas modelo) async {
    final finder = Finder(filter: Filter.equals("name", modelo.id));
    await _huertocollection.update(await _db, modelo.toMap(), finder: finder);
  }

//DELETE
  Future delete(Recetas modelo) async {
    final finder = Finder(filter: Filter.equals("name", modelo.id));
    await _huertocollection.delete(await _db, finder: finder);
  }

//DELETE ALL
  Future deleteall() async {
    await _huertocollection.delete(await _db);
  }

//Busca todos los huertos guardados
  Future<List<Recetas>> getAll() async {
    //Con el finder los ordena
    final finder = Finder(sortOrders: [SortOrder("name")]);
    //Se declara una variable final con el resultado
    final recordSnapshot =
        await _huertocollection.find(await _db, finder: finder);
    
    //Se retornan los resultados como map
    return recordSnapshot.map((f) {
      final huertos = Recetas.fromMap(f.value);
    //  print(huertos.toMap());
      return huertos;
      //Se parsean a una lista para mostrarlos como arreglo
    }).toList();
  }

    Future<List<Recetas>> getSearch(String value) async {
    //Con el finder los ordena
    final finder = Finder(sortOrders: [SortOrder("name")],filter: Filter.equals("category", value));
    //Se declara una variable final con el resultado
    final recordSnapshot =
        await _huertocollection.find(await _db, finder: finder);
    
    //Se retornan los resultados como map
    return recordSnapshot.map((f) {
      final huertos = Recetas.fromMap(f.value);
      return huertos;
      //Se parsean a una lista para mostrarlos como arreglo
    }).toList();
  }

   Future<List<Recetas>> getSearchVariety({String farm, String cuartel}) async {
    //Con el finder los ordena
    final finder = Finder(sortOrders: [SortOrder("cuartel")],filter: Filter.and([Filter.equals("farm", farm),Filter.equals("cuartel", cuartel)]) );
    //Se declara una variable final con el resultado
    final recordSnapshot =
        await _huertocollection.find(await _db, finder: finder);
    
    //Se retornan los resultados como map
    return recordSnapshot.map((f) {
      final huertos = Recetas.fromMap(f.value);
      return huertos;
      //Se parsean a una lista para mostrarlos como arreglo
    }).toList();
  }
}
