import 'package:crochet_app_flutter/database.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._title),
        centerTitle: true,
      ),
      body: Center(
        child: FutureBuilder<List<CrochetPattern>>(
            future: DatabaseHelper.instance.getPatterns(),
            builder: (BuildContext context, AsyncSnapshot<List<CrochetPattern>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              } else if (!snapshot.hasData) {
                return const Center(child: Text('Loading...'));
              }
              return snapshot.data!.isEmpty
                  ? const Center(child: Text('No patterns in List.'))
                  : Center(
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
                    itemCount: snapshot.data!.length,
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
                                      builder: (_) => UpdatePattern(snapshot.data![index])))
                                  .then((newContact) {
                                if (newContact != null) {
                                  setState(() {
                                    DatabaseHelper.instance
                                        .update(newContact);

                                    messageResponse(
                                        context,
                                        newContact.name +
                                            " Has been modified...!");
                                  });
                                }
                              });
                            },
                            onLongPress: () {
                              removePattern(context, snapshot.data![index]);
                            },
                            title: Text(snapshot.data![index].name),
                            subtitle: Text(snapshot.data![index].description),
                            trailing: Text.rich(TextSpan(
                                children: [
                                ]
                            )),
                          )
                      );
                    },
                  ),
                ),

              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => const AddPattern()))
              .then((newPattern) {
            if (newPattern != null) {
              DatabaseHelper.instance.add(newPattern);
              messageResponse(context, newPattern.name + " was added...!");
              setState((){});
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
                  try {
                    DatabaseHelper.instance.remove(pattern.id!);
                  } on Exception catch (_) {
                    rethrow;
                  }
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

  factory CrochetPattern.fromMap(Map<String, dynamic> json) => CrochetPattern(
    id: json['id'],
    name: json['name'],
    description: json['description'],
    category: json['category'],
    level: json['level'],
  );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'category': category,
      'level': level
    };
  }

}

messageResponse(BuildContext context, String name) {
  showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Message...!"),
        content: Text("Pattern $name"),
      ));
}