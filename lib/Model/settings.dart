class Settings {
  bool showGetReadyAnimation = true;
  bool showTimer = true;
  int timerDuration = 0;

  Settings(
      {required this.showGetReadyAnimation,
      required this.showTimer,
      required this.timerDuration});

  Settings.fromJson(Map<String, dynamic> json) {
    showGetReadyAnimation = json['showGetReadyAnimation'];
    showTimer = json['showTimer'];
    timerDuration = json['timerDuration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['showGetReadyAnimation'] = showGetReadyAnimation;
    data['showTimer'] = showTimer;
    data['timerDuration'] = timerDuration;

    return data;
  }
}
