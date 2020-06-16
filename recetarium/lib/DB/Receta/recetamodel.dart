import 'package:meta/meta.dart';

class Recetas {
  //Se piden los datos, en este caso name
  int id;
  String name;
  int steps;
  String time;
  List items;
  String category;
  String difficulty;
  String image;

  //Se declaran las llaves para pasar los datos, es necesario dejarlo así {this.name} o arrojará error
  Recetas(
      {@required this.id,
      @required this.name,
      @required this.steps,
      @required this.time,
      @required this.items,
      @required this.category,
      @required this.difficulty,
      @required this.image});

//Se crea el map para ingresar datos
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'steps': steps,
      'time': time,
      'items': items,
      'category':category,
      'difficulty':difficulty,
      'image':image
    };
  }

//Se crea el método fromMap para desglozarlo y obtener los campos
  static Recetas fromMap(Map<String, dynamic> map) {
    return Recetas(
        id: map['id'],
        name: map['name'],
        steps: map['steps'],
        time: map['time'],
        items: map['items'],
        category: map['category'],
        difficulty: map['difficulty'],
        image: map['image']);
  }
}
