class Question {
  String? instructions;
  String? questionID;
  Data? data;

  Question({this.instructions, this.questionID, this.data});

  Question.fromJson(Map<String, dynamic> json) {
    instructions = json['instructions'];
    questionID = json['questionID'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> questionData = <String, dynamic>{};
    questionData['instructions'] = instructions;
    questionData['questionID'] = questionID;
    if (data != null) {
      questionData['data'] = data!.toJson();
    }
    return questionData;
  }
}

class Data {
  QuestionMetadata? questionMetadata;
  String? stimulus;
  List<Options>? options;
  int? marks;
  String? type;

  Data(
      {this.questionMetadata,
      this.stimulus,
      this.options,
      this.marks,
      this.type});

  Data.fromJson(Map<String, dynamic> json) {
    questionMetadata = json['question_metadata'] != null
        ? QuestionMetadata.fromJson(json['question_metadata'])
        : null;
    stimulus = json['stimulus'];
    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options!.add(Options.fromJson(v));
      });
    }
    marks = json['marks'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (questionMetadata != null) {
      data['question_metadata'] = questionMetadata!.toJson();
    }
    data['stimulus'] = stimulus;
    if (options != null) {
      data['options'] = options!.map((v) => v.toJson()).toList();
    }
    data['marks'] = marks;
    data['type'] = type;
    return data;
  }
}

class QuestionMetadata {
  int? duration;
  String? difficulty;

  QuestionMetadata({this.duration, this.difficulty});

  QuestionMetadata.fromJson(Map<String, dynamic> json) {
    duration = json['duration'];
    difficulty = json['difficulty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['duration'] = duration;
    data['difficulty'] = difficulty;
    return data;
  }
}

class Options {
  List<Feedback>? feedback;
  int? score;
  String? label;
  int? value;
  int? isCorrect;

  Options({this.feedback, this.score, this.label, this.value, this.isCorrect});

  Options.fromJson(Map<String, dynamic> json) {
    if (json['feedback'] != null) {
      feedback = <Feedback>[];
      json['feedback'].forEach((v) {
        feedback!.add(Feedback.fromJson(v));
      });
    }
    score = json['score'];
    label = json['label'];
    value = json['value'];
    isCorrect = json['isCorrect'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (feedback != null) {
      data['feedback'] = feedback!.map((v) => v.toJson()).toList();
    }
    data['score'] = score;
    data['label'] = label;
    data['value'] = value;
    data['isCorrect'] = isCorrect;
    return data;
  }
}

class Feedback {
  String? text;

  Feedback({this.text});

  Feedback.fromJson(Map<String, dynamic> json) {
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['text'] = text;
    return data;
  }
}
