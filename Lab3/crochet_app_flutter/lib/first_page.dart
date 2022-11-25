import 'package:crochet_app_flutter/update_pattern.dart';
import 'package:flutter/material.dart';

import 'add_pattern.dart';

class FirstPage extends StatefulWidget{
  final String _title;
  FirstPage(this._title);

  @override
  State<StatefulWidget> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  List<CrochetPattern> patterns = [
    CrochetPattern(
        id: 0,
        name: 'Bunny toy',
        description: 'easy and fluffy bunny keychain',
        category: 'toy',
        level: 'easy'
    ),
    CrochetPattern(
        id: 1,
        name: 'Colorful scarf',
        description: 'scarf in 4 color',
        category: 'scarf',
        level: 'medium',
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._title),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.brown,
                  Colors.grey,
                ],
              )
          ),
          child: ListView.builder(
            itemCount: patterns.length,
            itemBuilder: (context, index) {
              return Padding(
                  padding:  EdgeInsets.only(left: 3, right: 3, top: 10),
                  child:
                  ListTile(
                    textColor: Colors.white,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => UpdatePattern(patterns[index])))
                          .then((newContact) {
                        if (newContact != null) {
                          setState(() {
                            patterns.removeAt(index);
                            newContact.id = index;
                            patterns.insert(index, newContact);
                            messageResponse(context,
                                newContact.name + " Has been modified...!");
                          });
                        }
                      });
                    },
                    onLongPress: () {
                      removePattern(context, patterns[index]);
                    },
                    title: Text(patterns[index].name),
                    subtitle: Text(patterns[index].description),
                    //leading:  CircleAvatar(
                    //  backgroundColor: Colors.deepPurple[800],
                    //  child: Text(patterns[index].name.substring(0, 1),style: const TextStyle(color:Colors.white)),
                    //),
                    trailing: Text.rich(TextSpan(
                        children: [
                          //TextSpan(text: "${patterns[index].rating}/10",style: const TextStyle(color:Colors.white)),
                          //const WidgetSpan(child: Icon(Icons.star_border_purple500_sharp)),
                        ]
                    )),
                  )
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => const AddPattern()))
              .then((newPattern) {
            if (newPattern != null) {
              setState(() {
                patterns.add(newPattern);
                messageResponse(context, newPattern.name + " was added...!");
              });
            }
          });
        },
        tooltip: "Add Pattern",
        child: const Icon(Icons.add),
      ),
    );
  }

  removePattern(BuildContext context, CrochetPattern pattern) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text("Delete Pattern"),
          content:
          Text("Are you sure you want to delete " + pattern.name + "?"),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  patterns.remove(pattern);
                  Navigator.pop(context);
                });
              },
              child: const Text(
                "Delete",
                style: TextStyle(color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "Cancel",
                style: TextStyle(color: Colors.brown),
              ),
            )
          ],
        ));
  }

}

class CrochetPattern {
  var id;
  var name;
  var description;
  var category;
  var level;

  CrochetPattern(
      { this.id,
        this.name,
        this.description,
        this.category,
        this.level}
      );

}

messageResponse(BuildContext context, String name) {
  showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Update Message...!"),
        content: Text("Pattern $name"),
      ));
}