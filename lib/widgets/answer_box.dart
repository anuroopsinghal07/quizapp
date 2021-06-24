import 'package:flutter/material.dart';
import 'package:quizapp/Model/question.dart';
import 'package:quizapp/Utility/utility.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flip_card/flip_card.dart';

class AnswerBox extends StatefulWidget {
  final Options option;
  final AnswersViewType answersViewType;
  final double gridHeight;
  final double gridWidth;

  final bool isUserSelection;

  const AnswerBox(
      {required this.option,
      required this.answersViewType,
      required this.gridHeight,
      required this.gridWidth,
      required this.isUserSelection,
      Key? key})
      : super(key: key);

  @override
  State<AnswerBox> createState() => _AnswerBoxState();
}

class _AnswerBoxState extends State<AnswerBox> {
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  double itemHeight = 0;
  double itemWidth = 0;

  bool _visibleFront = true;

  @override
  void initState() {
    super.initState();

    if (mounted && widget.isUserSelection) {
      _showRearSide();
    } else if (mounted && !widget.isUserSelection) {
      _fadeFront();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    //final screenWidth = MediaQuery.of(context).size.width;
    if (widget.answersViewType == AnswersViewType.grid) {
      itemWidth = (widget.gridWidth / 2) - 20;
      itemHeight = (widget.gridHeight / 2) - 20;
    } else if (widget.answersViewType == AnswersViewType.vertical) {
      itemWidth = widget.gridWidth - 20;
      itemHeight = (widget.gridHeight / 4) - 20;
    } else if (widget.answersViewType == AnswersViewType.horizontal) {
      itemHeight = (widget.gridWidth) - 20;
      itemWidth = (widget.gridHeight) - 20;

      // itemHeight = (screenWidth / 2);
      // itemWidth = (boxHeight / 2);
    }
  }

  _fadeFront() async {
    if (widget.option.isCorrect == 1) {
      await Future.delayed(const Duration(seconds: 2));
      if (mounted) {
        setState(() {
          _visibleFront = false;
        });
        _navigateBack();
      }
    }
  }

  _showRearSide() async {
    await Future.delayed(const Duration(seconds: 2));
    cardKey.currentState!.toggleCard();
  }

  _navigateBack() async {
    Future.delayed(const Duration(seconds: 2)).then((value) {
      Navigator.pop(context, true);
    });
  }

  // updateUI() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();

  //   if (prefs.containsKey(answersViewTypeKey)) {
  //     _answersViewType =
  //         AnswersViewType.values[prefs.getInt(answersViewTypeKey)!];
  //   } else {
  //     prefs.setInt(answersViewTypeKey, AnswersViewType.grid.index);
  //     _answersViewType = AnswersViewType.grid;
  //   }

  //   setState(() {
  //     _isloading = false;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Hero(
        flightShuttleBuilder:
            (context, anim, direction, fromContext, toContext) {
          final Hero toHero = toContext.widget as Hero;
          if (direction == HeroFlightDirection.pop &&
              widget.option.isCorrect == 1) {
            return FadeTransition(
              opacity: const AlwaysStoppedAnimation(0),
              child: toHero.child,
            );
          } else {
            return toHero.child;
          }
        },
        tag: widget.option.hashCode,
        child: DefaultTextStyle(
          style: const TextStyle(decoration: TextDecoration.none),
          child: widget.isUserSelection
              ? FlipCard(
                  key: cardKey,
                  flipOnTouch: false,
                  direction: FlipDirection.HORIZONTAL, // default
                  front: _buildFront(),
                  back: _buildRear(),
                  onFlipDone: (value) {
                    _navigateBack();
                  },
                )
              : _buildFront(),
        ),

        // Container(
        //   height: itemHeight,
        //   width: itemWidth,
        //   margin: const EdgeInsets.all(10),
        //   decoration: const BoxDecoration(
        //       color: Colors.white,
        //       borderRadius: BorderRadius.all(Radius.circular(10))),
        //   child: Center(
        //     child: AnimatedSwitcher(
        //       duration: const Duration(milliseconds: 600),
        //       child: _showFrontSide ? _buildFront() : _buildRear(),
        //     ),
        //   ),
        // ),
      ),
    );
  }

  Widget _buildFront() {
    var container = Container(
      height: itemHeight,
      width: itemWidth,
      margin: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Center(
        child: AutoSizeText(
          widget.option.label?.parseHtmlString() ?? "",
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: 25, fontWeight: FontWeight.normal, color: Colors.black),
        ),
      ),
    );
    return widget.isUserSelection
        ? container
        : AnimatedOpacity(
            // If the widget is visible, animate to 0.0 (invisible).
            // If the widget is hidden, animate to 1.0 (fully visible).
            opacity: _visibleFront ? 1.0 : 0.0,
            duration: const Duration(seconds: 2),
            // The green box must be a child of the AnimatedOpacity widget.
            child: container,
          );
  }

  Widget _buildRear() {
    return BuildRear(
        option: widget.option, itemHeight: itemHeight, itemWidth: itemWidth);
  }
}

class BuildRear extends StatefulWidget {
  final Options option;

  const BuildRear({
    required this.option,
    Key? key,
    required this.itemHeight,
    required this.itemWidth,
  }) : super(key: key);

  final double itemHeight;
  final double itemWidth;

  @override
  State<BuildRear> createState() => _BuildRearState();
}

class _BuildRearState extends State<BuildRear> {
  bool _visible = true;

  @override
  void initState() {
    super.initState();

    if (mounted) {
      _fadeContainer();
    }
  }

  _fadeContainer() async {
    if (widget.option.isCorrect == 1) {
      await Future.delayed(const Duration(seconds: 4));
      if (mounted) {
        setState(() {
          _visible = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    print('_BuildRearState');
    return AnimatedOpacity(
      // If the widget is visible, animate to 0.0 (invisible).
      // If the widget is hidden, animate to 1.0 (fully visible).
      opacity: _visible ? 1.0 : 0.0,
      duration: const Duration(seconds: 2),
      // The green box must be a child of the AnimatedOpacity widget.
      child: Container(
        height: widget.itemHeight,
        width: widget.itemWidth,
        margin: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Center(
          child: Icon(
            widget.option.isCorrect! == 1 ? Icons.check : Icons.close,
            color: widget.option.isCorrect! == 1
                ? Theme.of(context).primaryColor
                : Colors.red,
            size: 30,
          ),
        ),
      ),
    );
  }
}
