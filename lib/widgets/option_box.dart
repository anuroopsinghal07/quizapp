import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:quizapp/Model/question.dart';
import 'package:quizapp/Utility/utility.dart';

class OptionBox extends StatelessWidget {
  final Options option;

  const OptionBox({required this.option, key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('option box ${option.hashCode}');
    return Hero(
      tag: option.hashCode,
      child: DefaultTextStyle(
        style: const TextStyle(decoration: TextDecoration.none),
        child: Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(5),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Center(
            child: AutoSizeText(option.label?.parseHtmlString() ?? "",
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.normal,
                    color: Colors.black)),
          ),
        ),
      ),
    );
  }
}
