import 'package:html/parser.dart';

extension FilterHTMLTag on String {
  String parseHtmlString() {
    final document = parse(this);
    if (parse(this).documentElement != null) {
      return parse(document.body?.text).documentElement!.text;
    }
    //final String parsedString = parse(this).documentElement!.text;

    return "";
  }
}

enum AnswersViewType {
  grid,
  horizontal,
  vertical,
}
