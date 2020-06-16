import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

buildCardCollpased({String title, String subtitle, String image}) {
  return Card(
    child: ListTile(
        leading: Image.asset(
          image,
          height: 56,
        ),
        title: Text(title),
        subtitle: Text(subtitle),
        // trailing: Icon(Icons.more_vert),
        trailing: ExpandableButton(
          // <-- Collapses when tapped on
          child: Icon(Icons.keyboard_arrow_down),
        )),
  );
}

buildCardExpanded(
    {String title,
    String subtitle,
    String difficulty,
    String image,
    BuildContext context}) {
  return Card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ListTile(
            leading: Image.asset(
              image,
              height: 56,
            ), //FlutterLogo(size: 56.0),
            title: Text(title),
            subtitle: Text(subtitle),
            // trailing: Icon(Icons.more_vert),
            trailing: ExpandableButton(
              // <-- Collapses when tapped on
              child: Icon(Icons.keyboard_arrow_up),
            )),
        SizedBox(
          height: 20,
        ),
        Image.asset(
          image,
          height: 56,
          fit: BoxFit.cover,
          width: MediaQuery.of(context).size.width,
        ),
        Center(
          child: buildTextExpandedTitle("$title"),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        buildTextExpanded("$subtitle"),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        buildTextExpanded("$difficulty"),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        Center(
          child: FloatingActionButton(
            backgroundColor: Colors.amber,
            child: Icon(
              Icons.import_contacts,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    ),
  );
}

buildTextExpanded(String texto) {
  return Text(texto,
      style: TextStyle(
        color: Colors.black,
        fontSize: 20,
      ));
}

buildTextExpandedTitle(String texto) {
  return Text(texto,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.black,
        fontSize: 20,
      ));
}
