import 'package:crochet_app_flutter/first_page.dart';
import 'package:flutter/material.dart';


class UpdatePattern extends StatefulWidget {
  final CrochetPattern _pattern;

  const UpdatePattern(this._pattern, {super.key});

  @override
  State<StatefulWidget> createState() => _UpdatePattern();
}

class _UpdatePattern extends State<UpdatePattern> {
  late TextEditingController controllerName;
  late TextEditingController controllerDescription;
  late TextEditingController controllerCategory;
  late TextEditingController controllerLevel;

  @override
  void initState() {
    CrochetPattern aux_pattern = widget._pattern;
    controllerName = TextEditingController(text:aux_pattern.name);
    controllerDescription = TextEditingController(text: aux_pattern.description);
    controllerCategory =
        TextEditingController(text: aux_pattern.category);
    controllerLevel =
        TextEditingController(text: aux_pattern.level);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Update Pattern"),
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
                  child: const Text("Save Pattern")),
            ],
          ),
        ));
  }
}