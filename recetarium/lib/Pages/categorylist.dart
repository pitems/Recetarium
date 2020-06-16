import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:recetarium/DB/Receta/recetacollection.dart';
import 'package:recetarium/DB/Receta/recetamodel.dart';
import 'package:recetarium/Tools/Hex.dart';
import 'package:recetarium/Tools/cards.dart';

class CategoryList extends StatefulWidget {
  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: HexColor("#FFEBCD"),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Container(
              //Banner Image
              child: Image.asset(
                "assets/bigbanner/bigfishbanner.jpg",
                height: 150,
                fit: BoxFit.fitWidth,
              ),
            ),
            listfood()
          ],
        ),
      ),
    );
  }

  //Widgets
  Widget listfood() {
    return Expanded(
      child: FutureBuilder(
          future: RecetaCollection().getSearch("Fish"),
          builder: (context, snap) {
            List<Recetas> data = snap.data;
            return ListView.builder(
              physics: ScrollPhysics(parent: BouncingScrollPhysics()),
              itemCount: snap.data.length,
              itemBuilder: (context, index) {
                if (snap.hasError) return Text("FUCK YOU");
                if (data.length == 0) return Text("NO DATA ");
                return ExpandableNotifier(
                  // <-- Provides ExpandableController to its children
                  child: ScrollOnExpand(
                    child: Column(
                      children: [
                        Expandable(
                          // <-- Driven by ExpandableController from ExpandableNotifier
                          collapsed: ExpandableButton(
                            // <-- Expands when tapped on the cover photo
                            child: buildCardCollpased(
                                title: "${data[index].name}",
                                subtitle: "Tiempo: ${data[index].time}",
                                image: "${data[index].image}"),
                          ),
                          expanded: Column(children: [
                            buildCardExpanded(
                                context: context,
                                image: "${data[index].image}",
                                title: "${data[index].name}",
                                subtitle: "Tiempo: ${data[index].time}",
                                difficulty:
                                    "Dificultad : ${data[index].difficulty}"),
                            /* ExpandableButton(       // <-- Collapses when tapped on
                              child: Text("Cerrar"),
                            ),*/
                          ]),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }),
    );
  }
}
