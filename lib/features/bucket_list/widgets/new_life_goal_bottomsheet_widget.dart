import 'package:diem/features/bucket_list/models/life_goal_category/life_goal_category.dart';
import 'package:diem/features/bucket_list/widgets/life_goal_categories_widget.dart';
import 'package:diem/features/database/local/life_goal_category/life_goal_category_local_db_helper.dart';
import 'package:diem/features/database/local_db_singleton.dart';
import 'package:diem/utils/input_validator.dart';
import 'package:diem/utils/widgets/custom_chip.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqlite_api.dart';

class NewLifeGoalBottomSheet extends StatefulWidget {
  final TextEditingController titleController;
  final GlobalKey<FormState> formKey;
  final List<LifeGoalCategory> selectedCategories = [];

  NewLifeGoalBottomSheet(
      {super.key, required this.titleController, required this.formKey});

  @override
  State<NewLifeGoalBottomSheet> createState() => _NewLifeGoalBottomSheetState();
}

class _NewLifeGoalBottomSheetState extends State<NewLifeGoalBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, state) {
      return SizedBox(
        height: 500,
        child: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: widget.formKey,
              child: ListView(children: [
                TextFormField(
                  controller: widget.titleController,
                  decoration: const InputDecoration(
                    label: Text("Title"),
                  ),
                  validator: (value) {
                    String? validationResult = InputValidator(input: value)
                        .isRequired()
                        .maxLength(maxLength: 20)
                        .validate();

                    return validationResult;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      label: Text("Description"), hintMaxLines: 4),
                  validator: (value) {
                    String? result = InputValidator(input: value)
                        .isRequired()
                        .maxLength(maxLength: 250)
                        .validate();
                    return result;
                  },
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text("Categories"),
                ),
                LifeGoalCategoriesWidget(
                    selectedCategories: widget.selectedCategories),
                TextFormField(
                  decoration: const InputDecoration(
                      label: Text("Location"), hintMaxLines: 4),
                ),
                TextFormField(
                  maxLength: 300,
                  maxLines: 6,
                  minLines: 1,
                  decoration: const InputDecoration(
                      label: Text("Notes"), hintMaxLines: 4),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      label: Text("Image"), hintMaxLines: 4),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: ElevatedButton(
                      onPressed: () {
                        widget.formKey.currentState!.validate();
                      },
                      child: const Text("CREATE NEW LIFE GOAL")),
                ),
              ]),
            ),
          ),
        ),
      );
    });
  }

  _chipList() async {
    Database db = await LocalDBSingleton().database;

    List<LifeGoalCategory> categories =
        await LifeGoalCategoryDBHelper(instance: db).getLifeGoalCategories();

    List<CustomChip> customChipList = categories
        .map((e) => CustomChip(
              category: e,
              selectedCategories: widget.selectedCategories,
            ))
        .toList();

    return Wrap(
      children: customChipList,
    );
  }
}
