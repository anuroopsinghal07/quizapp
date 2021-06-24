import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:quizapp/Utility/constant.dart';
import 'package:quizapp/Utility/utility.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
          child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: AutoSizeText(
                "Select to change options layout",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.normal,
                    color: Colors.white),
              ),
            ),
            SizedBox(
              width: 200,
              child: TextButton(
                onPressed: () {
                  handleOptionSelection(AnswersViewType.grid, context);
                },
                child: const Text(
                  'Grid',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey.shade900,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // <-- Radius
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 200,
              child: TextButton(
                onPressed: () {
                  handleOptionSelection(AnswersViewType.horizontal, context);
                },
                child: const Text(
                  'Horizontal',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey.shade900,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // <-- Radius
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 200,
              child: TextButton(
                onPressed: () {
                  handleOptionSelection(AnswersViewType.vertical, context);
                },
                child: const Text(
                  'Vertical',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey.shade900,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // <-- Radius
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }

  handleOptionSelection(AnswersViewType type, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setInt(answersViewTypeKey, type.index);

    Navigator.pop(context, true);
  }
}
