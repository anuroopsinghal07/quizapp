class Answer {
  String questionId;
  int score;
  int time;

  Answer({
    required this.questionId,
    required this.score,
    required this.time,
  });

  factory Answer.fromMap(Map<String, dynamic> map) => Answer(
        questionId: map["questionId"],
        score: map["score"],
        time: map["time"],
      );

  Map<String, dynamic> toMap() => {
        'questionId': questionId,
        'score': score,
        'time': time,
      };
}
