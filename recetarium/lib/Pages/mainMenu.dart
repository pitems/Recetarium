import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:recetarium/DB/Receta/recetacollection.dart';
import 'package:recetarium/DB/Receta/recetamodel.dart';
import 'package:recetarium/Tools/Hex.dart';

class MainMenu extends StatefulWidget {
  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  List<String> images = [
    "assets/fish.png",
    "assets/meat.png",
    "assets/vegies.png",
    "assets/milky.png",
    "assets/glutenfree.png",
    "assets/cake.png",
    "assets/soup.png"
  ];

  List<String> subtext = [
    "Pescado",
    "Carnes",
    "Verduras",
    "Lacteos",
    "Celiacos",
    "Postres",
    "Sopas"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: HexColor("#FFEBCD"),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Container(
                child: CarouselSlider(
              options: CarouselOptions(
                  height: MediaQuery.of(context).size.height * 0.3,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 5),
                  autoPlayAnimationDuration: Duration(milliseconds: 800)),
              items: [1, 2, 3, 4, 5].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(color: HexColor("#F5DEB3")),
                        child: Center(
                          child: i == 3
                              ? banner("assets/minibanner.jpg",
                                  "Recetas de \nPostres")
                              : i == 2
                                  ? banner("assets/minibannersoup.jpg",
                                      "Recetas de \nSopa")
                                  : i == 1
                                      ? banner("assets/minibannerfish.jpg",
                                          "Recetas de \n Pescado")
                                      : i == 4
                                          ? banner("assets/minibannersalad.jpg",
                                              "Ensalada \nCesar")
                                          : banner("assets/glutenfree.jpg",
                                              "Recetas sin \n Gluten"),
                        ));
                  },
                );
              }).toList(),
            )),
            Expanded(child: grid())
          ],
        ),
      ),
    );
  }

  //Widgets
  Widget grid() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 0, 16, 0),
      child: GridView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: images.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, crossAxisSpacing: 1, mainAxisSpacing: 50),
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                callCategory(index);
              },
              child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Column(
                    children: <Widget>[
                      Image.asset(
                        images[index],
                        height: MediaQuery.of(context).size.height * 0.13,
                      ),
                      Text("${subtext[index]}")
                    ],
                  )),
            );
          }),
    );
  }

  Widget banner(String bannerimage, String title) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width * 0.4,
          child: Image.asset(
            bannerimage,
            fit: BoxFit.cover,
          ),
        ),
        ClipPath(
          clipper: PointsClipper(),
          child: Container(
            decoration: BoxDecoration(
              gradient: Gradients.haze,
            ),
            height: 100,
            width: MediaQuery.of(context).size.width * 0.3722,
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        )
      ],
    );
  }

  callCategory(int index) async {
    if (index == 0) {
      print("Pescado");
      Navigator.pushNamed(context, '/category', arguments: {'index': index});
    }
    if(index==3){
      RecetaCollection().deleteall();
    }
    if (index == 2) {
      print("Insertando");
      var id = await RecetaCollection().getAll();
      int index = id.length;
      List elementos = ["Pescado", "Ajo", "Cebolla", "Limon"];
      var modelo = Recetas(
          id: index,
          name: "Pescado a la Plancha",
          steps: 5,
          time: "1:30",
          items: elementos,
          category: "Fish",
          difficulty: "Media",
          image: "assets/bigbanner/bigfishbanner.jpg");
      RecetaCollection().insert(modelo);
    }
  }
}
