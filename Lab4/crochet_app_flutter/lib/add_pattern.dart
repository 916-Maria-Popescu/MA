import 'package:crochet_app_flutter/first_page.dart';
import 'package:flutter/material.dart';

class AddPattern extends StatefulWidget {
  const AddPattern({super.key});

  @override
  State<StatefulWidget> createState() => _AddPattern();
}

class _AddPattern extends State<AddPattern> {
  late TextEditingController controllerName;
  late TextEditingController controllerDescription;
  late TextEditingController controllerCategory;
  late TextEditingController controllerLevel;

  @override
  void initState() {
    controllerName = TextEditingController();
    controllerDescription = TextEditingController();
    controllerCategory = TextEditingController();
    controllerLevel = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("New Pattern"),
        ),
        body: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Colors.brown,
                    Colors.grey,
                  ],
                )),
            child: ListView(

              children: [
                Text("Name"),
                TextField(controller: controllerName),
                Text("Description"),
                TextField(controller: controllerDescription),
                Text("Category"),
                TextField(controller: controllerCategory),
                Text("Level"),
                TextField(controller: controllerLevel),
                ElevatedButton(
                    onPressed: () {
                      String name = controllerName.text;
                      String description = controllerDescription.text;
                      String category = controllerCategory.text;
                      String level = controllerLevel.text;

                      if (name.isNotEmpty &&
                          description.isNotEmpty &&
                          category.isNotEmpty &&
                          level.isNotEmpty) {
                        Navigator.pop(
                            context,
                            CrochetPattern(
                                name: name,
                                description: description,
                                category: category,
                                level: level));
                      }
                    },
                    child: const Text("Add Pattern")),
              ],
            )));
  }
}