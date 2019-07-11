import 'package:flutter/material.dart';
import 'dart:math';
import 'package:country_quiz/fix_pub_lib/country_pickers_1.1.0_fix/country.dart';
import 'package:flutter/widgets.dart';

List<Size> _cardSizes = new List();
List<Alignment> _cardAligns = new List();

/// A Tinder-Like Widget.
// ignore: must_be_immutable
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
  double _ratioOfPositionX = 0.0;
  bool _dragCheck = false;
  double _tapPositionX= 0.0;
  double _opacityIndicator = 0.0;
  String _countryName = '';
  double _cardRote = 0.0;
  Alignment frontCardAlign;
  AnimationController _animationController;
  int _currentFront;
  int _counter = 0;
  Alignment _iconDisplayAlignment;

  Widget _buildCard(BuildContext context, int realIndex) {
    var _tinderFrontMostWidget;

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
            _countryName = widget.countryNames[_counter].name;
            _tapPositionX = details.globalPosition.dx;
            _dragCheck = true;
          });
        },
        onTapUp: (details) {
          _dragCheck = false;
        },
        onPanUpdate: (DragUpdateDetails details) {
          setState(() {
            if(!_dragCheck) {
              _tapPositionX = details.globalPosition.dx;
              _dragCheck = true;
            }

            _countryName = widget.countryNames[_counter].name;
            frontCardAlign = new Alignment(
                frontCardAlign.x +
                    details.delta.dx * 20 / MediaQuery.of(context).size.width,
                frontCardAlign.y +
                    details.delta.dy * 13 / MediaQuery.of(context).size.height);

            _cardRote = frontCardAlign.x;

            _ratioOfPositionX = (details.globalPosition.dx - _tapPositionX) / MediaQuery.of(context).size.width;

//            print(_ratioOfPositionX);
            if (_ratioOfPositionX > 0.1) {
//             print('Right');
             setState(() {
               _opacityIndicator = _ratioOfPositionX - 0.1;
               _opacityIndicator = min(_opacityIndicator + _opacityIndicator/0.3, 1);
               _iconDisplayAlignment = Alignment.centerLeft;
             });
           } else if (_ratioOfPositionX < -0.1){
//             print('Left');
             setState(() {
               _opacityIndicator = _ratioOfPositionX.abs() -0.1;
               _opacityIndicator = min(_opacityIndicator + _opacityIndicator/0.3, 1);
               _iconDisplayAlignment = Alignment.centerRight;
             });
           }
//            print(_opacityIndicator);

            if (widget.swipeUpdateCallback != null) {
//              print(details);
              widget.swipeUpdateCallback(details);
            }
          });
        },
        onPanEnd: (DragEndDetails details) {
          _opacityIndicator = 0.0;
          _dragCheck = false;
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

  Widget _frontMostCard(BuildContext context, int index) { // 最前面のカード

    return GestureDetector(
      child: Stack(
        children: <Widget>[
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40.0),
            ),
            color: Colors.grey[200],
            child: Column(
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
//                Spacer(),
                Container(
                  alignment: Alignment.topCenter,
                  padding: EdgeInsets.only(top: 2, left: MediaQuery.of(context).size.width / 10, right: MediaQuery.of(context).size.width / 10),
                  child: Text(
                    _countryName,
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width / 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
          Opacity(
            opacity: _opacityIndicator,
//            opacity: 1,
            child: Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              height: MediaQuery.of(context).size.height / 1.5,
              width: MediaQuery.of(context).size.width / 1.15,
              alignment: _iconDisplayAlignment,
              child: _iconDisplay(),
            ),
          ),
        ],
      ),
//        onTapDown: (detail) {
//          setState(() {
//            print(detail);
//            _countryName = widget.countryNames[index].name;
//          });
//        }
    );
  }

  Widget _iconDisplay() {
    if (_ratioOfPositionX < 0.1) {
      return Icon(
        Icons.help_outline,
        size: MediaQuery.of(context).size.width / 4,
        color: Colors.cyanAccent[400],
      );
    } else {
      return Icon(
        Icons.panorama_fish_eye,
        size: MediaQuery.of(context).size.width / 4,
        color: Colors.orange,
      );
    }
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