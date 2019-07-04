import 'package:flutter/material.dart';
import 'dart:math';
import 'package:country_quiz/fix_pub_lib/country_pickers_1.1.0_fix/country.dart';

List<Size> _cardSizes = new List();
List<Alignment> _cardAligns = new List();

/// A Tinder-Like Widget.
class TinderSwapCard extends StatefulWidget {
  List<Country> countryNames;
  List<Image> countryImageWidgets;
  CardBuilder _cardBuilder;
  int _totalNum;
  int _stackNum;
  CardSwipeCompleteCallback swipeCompleteCallback;
  CardDragUpdateCallback swipeUpdateCallback;

//  double _maxWidth;
//  double _minWidth;
//  double _maxHeight;
//  double _minHeight;

  @override
  _TinderSwapCardState createState() => _TinderSwapCardState();

  /// Constructor requires Card Widget Builder [cardBuilder] & your card count [totalNum]
  /// , option includes: stack orientation [orientation], number of card display in same time [stackNum]
  /// , and size control params;
  TinderSwapCard(
      {@required CardBuilder cardBuilder,
        @required int totalNum,
        AmassOrientation orientation = AmassOrientation.BOTTOM,
        int stackNum = 3,
        double maxWidth,
        double maxHeight,
        double minWidth,
        double minHeight,
        this.countryImageWidgets,
        this.countryNames,
        this.swipeCompleteCallback,
        this.swipeUpdateCallback})
      : this._cardBuilder = cardBuilder,
        this._totalNum = totalNum,
        assert(stackNum > 1),
        this._stackNum = stackNum,
        assert(maxWidth > minWidth && maxHeight > minHeight)
//        this._maxWidth = maxWidth,
//        this._minWidth = minWidth,
//        this._maxHeight = maxHeight,
//        this._minHeight = minHeight
  {
    double widthGap = maxWidth - minWidth;
    double heightGap = maxHeight - minHeight;

    _cardAligns = new List();
    _cardSizes = new List();

    for (int i = 0; i < _stackNum; i++) {
      _cardSizes.add(new Size(minWidth + (widthGap / _stackNum) * i,
          minHeight + 50 + (heightGap / _stackNum) * i));

      switch (orientation) {
        case AmassOrientation.BOTTOM:
          _cardAligns.add(
              new Alignment(0.0, (0.5 / (_stackNum - 1)) * (stackNum - i)));
          break;
        case AmassOrientation.TOP:
          _cardAligns.add(
              new Alignment(0.0, (-0.5 / (_stackNum - 1)) * (stackNum - i)));
          break;
        case AmassOrientation.LEFT:
          _cardAligns.add(
              new Alignment((-0.5 / (_stackNum - 1)) * (stackNum - i), 0.0));
          break;
        case AmassOrientation.RIGHT:
          _cardAligns.add(
              new Alignment((0.5 / (_stackNum - 1)) * (stackNum - i), 0.0));
          break;
      }
    }
  }
}

class _TinderSwapCardState extends State<TinderSwapCard>
    with SingleTickerProviderStateMixin {
  String _countryName = '';
  double _cardRote = 0.0;
  Alignment frontCardAlign;
  AnimationController _animationController;
  int _currentFront;
  int _counter = 0;

  Widget _buildCard(BuildContext context, int realIndex) {
//    print(_cardRote);
//    print(_animationController.status);

    var _tinderFrontMostWidget;
//    print(realIndex);
//    print('huronto');
//    print(_currentFront);

    if (realIndex < 0) {
      return Container();
    }
    int index = realIndex - _currentFront;

    if (index == widget._stackNum - 1) {
      if (index == 4) {
        _tinderFrontMostWidget = _frontMostCard(context, widget._totalNum - realIndex - 1);
      } else {
        _tinderFrontMostWidget = widget._cardBuilder(
            context, widget._totalNum - realIndex - 1);
      }

      return Align(
        alignment: _animationController.status == AnimationStatus.forward
            ? CardAnimation.frontCardAlign(_animationController, frontCardAlign,
            _cardAligns[widget._stackNum - 1])
            .value
            : frontCardAlign,
        child: Transform.rotate(
          angle: (pi / 180.0) *
              (_animationController.status == AnimationStatus.forward
                  ? CardAnimation.frontCardRota(
                  _animationController, _cardRote)
                  .value
                  : _cardRote),
          child: new SizedBox.fromSize(
            size: _cardSizes[index],
            child: _tinderFrontMostWidget,
          )
        ),
      );
    }
    return Align(
      alignment: _animationController.status == AnimationStatus.forward &&
          (frontCardAlign.x > 3.0 || frontCardAlign.x < -3.0)
          ? CardAnimation.backCardAlign(_animationController,
          _cardAligns[index], _cardAligns[index + 1])
          .value
          : _cardAligns[index],
      child: new SizedBox.fromSize(
        size: _animationController.status == AnimationStatus.forward &&
            (frontCardAlign.x > 3.0 || frontCardAlign.x < -3.0)
            ? CardAnimation.backCardSize(_animationController,
            _cardSizes[index], _cardSizes[index + 1])
            .value
            : _cardSizes[index],
        child: widget._cardBuilder(
            context, widget._totalNum - realIndex - 1),
      ),
    );
  }

  List<Widget> _buildCards(BuildContext context) {
    List<Widget> cards = new List();
    for (int i = _currentFront; i < _currentFront + widget._stackNum; i++) {
      cards.add(_buildCard(context, i));
    }

    cards.add(new SizedBox.expand(
      child: new GestureDetector(
        onTapDown: (details) {
          setState(() {
            _countryName = widget.countryNames[_counter].jpName;
//            print(widget.countryNames[_counter].jpName);
          });
        },
        onPanUpdate: (DragUpdateDetails details) {
          setState(() {
            frontCardAlign = new Alignment(
                frontCardAlign.x +
                    details.delta.dx * 20 / MediaQuery.of(context).size.width,
                frontCardAlign.y +
                    details.delta.dy * 13 / MediaQuery.of(context).size.height);

            _cardRote = frontCardAlign.x;
            print(_cardRote);
           if (_cardRote > 0) {
             print('YOU');
           } else {
             print('ME');
           }

            if (widget.swipeUpdateCallback != null) {
              print(details);
              widget.swipeUpdateCallback(details);
            }
          });
        },
        onPanEnd: (DragEndDetails details) {
          animateCards();
        },
      ),
    ));
    return cards;
  }

  animateCards() {
    _animationController.stop();
    _animationController.value = 0.0;
    _animationController.forward();
  }

  @override
  void initState() {
    super.initState();
    _currentFront = widget._totalNum - widget._stackNum;

    frontCardAlign = _cardAligns[_cardAligns.length - 1];
    _animationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 100));
    _animationController.addListener(() => setState(() {}));
    _animationController.addStatusListener((AnimationStatus status) {
      int index = widget._totalNum - widget._stackNum - _currentFront;
      if (status == AnimationStatus.completed) {
        if (frontCardAlign.x < 3.0 && frontCardAlign.x > -3.0) {
          frontCardAlign = _cardAligns[widget._stackNum - 1];
          _cardRote = 0.0;
          if (widget.swipeCompleteCallback != null) {
            widget.swipeCompleteCallback(CardSwipeOrientation.RECOVER, index);
          }
        } else {
          if (widget.swipeCompleteCallback != null) {
            _countryName = '';
            _counter++;
            widget.swipeCompleteCallback(frontCardAlign.x < 0
                ? CardSwipeOrientation.LEFT
                : CardSwipeOrientation.RIGHT, index);
          }
          changeCardOrder();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: _buildCards(context));
  }

  changeCardOrder() {
    setState(() {
      _currentFront--;
      _cardRote = 0.0;
      frontCardAlign = _cardAligns[widget._stackNum - 1];
    });
  }

  Widget _frontMostCard(BuildContext context, int index) {

    return GestureDetector(
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40.0),
          ),
          color: Colors.grey[200],
          child: Column(
            //                            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                height: 40,
              ),
              Container(
                alignment: Alignment.topCenter,
                height: MediaQuery.of(context).size.height/ 3,
                margin: EdgeInsets.only(left: 10, right: 10),
                child: widget.countryImageWidgets[index],
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: Text(
                  _countryName,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Spacer(),
            ],
          ),
        ),
//        onTapDown: (detail) {
//          setState(() {
//            print(detail);
//            _countryName = widget.countryNames[index].jpName;
//          });
//        }
    );
  }
}

typedef Widget CardBuilder(BuildContext context, int index);

enum CardSwipeOrientation { LEFT, RIGHT, RECOVER }

/// swipe card to [CardSwipeOrientation.LEFT] or [CardSwipeOrientation.RIGHT]
/// , [CardSwipeOrientation.RECOVER] means back to start.
typedef CardSwipeCompleteCallback = void Function(
    CardSwipeOrientation orientation, int index);

/// [DragUpdateDetails] of swiping card.
typedef CardDragUpdateCallback = void Function(DragUpdateDetails details);

enum AmassOrientation { TOP, BOTTOM, LEFT, RIGHT }

class CardAnimation {
  static Animation<Alignment> frontCardAlign(AnimationController controller,
      Alignment beginAlign, Alignment baseAlign) {
    double endX = beginAlign.x > 0
        ? (beginAlign.x > 3.0 ? beginAlign.x + 10.0 : baseAlign.x)
        : (beginAlign.x < -3.0 ? beginAlign.x - 10.0 : baseAlign.x);
    return new AlignmentTween(
        begin: beginAlign, end: new Alignment(endX, baseAlign.y))
        .animate(
        new CurvedAnimation(parent: controller, curve: Curves.easeOut));
  }

  static Animation<double> frontCardRota(
      AnimationController controller, double beginRot) {
    return new Tween(begin: beginRot, end: 0.0).animate(
        new CurvedAnimation(parent: controller, curve: Curves.easeOut));
  }

  static Animation<Size> backCardSize(
      AnimationController controller, Size beginSize, Size endSize) {
    return new SizeTween(begin: beginSize, end: endSize).animate(
        new CurvedAnimation(parent: controller, curve: Curves.easeOut));
  }

  static Animation<Alignment> backCardAlign(AnimationController controller,
      Alignment beginAlign, Alignment endAlign) {
    return new AlignmentTween(begin: beginAlign, end: endAlign).animate(
        new CurvedAnimation(parent: controller, curve: Curves.easeOut));
  }
}