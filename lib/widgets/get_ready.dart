import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

class GetReady extends StatefulWidget {
  final VoidCallback onCompletion;

  const GetReady({required this.onCompletion, Key? key}) : super(key: key);

  @override
  _GetReadyState createState() => _GetReadyState();
}

class _GetReadyState extends State<GetReady> {
  bool selected = false;
  bool endAnimation = false;

  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 5;

  @override
  void initState() {
    super.initState();
    startAnimation();
  }

  startAnimation() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      selected = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    double? containerHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      height: containerHeight,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // ignore: sized_box_for_whitespace
          Container(
            //color: Colors.red,
            height: containerHeight * 0.4,
            width: double.infinity,
            child: AnimatedAlign(
              alignment: selected ? Alignment.center : Alignment.topCenter,
              duration: const Duration(seconds: 1),
              curve: Curves.fastOutSlowIn,
              child: AnimatedOpacity(
                opacity: endAnimation ? 0 : 1,
                duration: const Duration(seconds: 1),
                child: Text(
                  selected ? 'Get Ready!' : '',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).textTheme.headline6!.color,
                  ),
                ),
              ),
            ),
          ),
          //Container(
          //margin: EdgeInsets.only(top: containerHeight * 0.2),
          //child:
          if (selected)
            Expanded(
              child: CountdownTimer(
                endTime: endTime,
                onEnd: () async {
                  setState(() {
                    endAnimation = true;
                  });

                  Future.delayed(const Duration(seconds: 1));

                  widget.onCompletion();
                },
                widgetBuilder: (_, time) {
                  if (time == null) {
                    return _BuildTimeTextWidget(
                        endAnimation: endAnimation, time: "1");
                  }
                  return _BuildTimeTextWidget(
                      endAnimation: endAnimation, time: "${time.sec}");
                },
              ),
            ),
          //),
        ],
      ),
    );
  }
}

class _BuildTimeTextWidget extends StatelessWidget {
  final String time;
  final bool endAnimation;
  const _BuildTimeTextWidget({
    required this.time,
    required this.endAnimation,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: endAnimation ? 0 : 1,
      duration: const Duration(seconds: 1),
      child: Text(
        time,
        style: TextStyle(
            fontSize: 120,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).textTheme.headline6!.color),
      ),
    );
  }
}
