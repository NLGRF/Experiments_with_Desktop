import 'package:flutter/material.dart';

class DarkInkBar extends StatefulWidget {
  final bool darkModeValue;

  const DarkInkBar({Key key, this.darkModeValue}) : super(key: key);

  @override
  _DarkInkBarState createState() => _DarkInkBarState(darkModeValue);
}

class _DarkInkBarState extends State<DarkInkBar>
    with SingleTickerProviderStateMixin {
  static final Color darkColor = Color(0xFF171137);
  static final Color lightColor = Color(0xFF67ECDC);

  AnimationController _controller;
  Animation<double> _iconOpacityAnimation;
  ImageProvider _darkModeToggleIconImage;

  bool darkModeValue;

  _DarkInkBarState(this.darkModeValue);

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _iconOpacityAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 0.0),
        weight: .20,
      ),
      TweenSequenceItem(
        tween: ConstantTween<double>(0.0),
        weight: .20,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.0, end: 1.0),
        weight: .20,
      ),
    ]).animate(_controller);

    _darkModeToggleIconImage = AssetImage('assets/images/icon-moon.png');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //
    final appSize = MediaQuery.of(context).size;

    return Positioned(
      left: 0,
      top: 0,
      width: appSize.width,
      child: Column(
        children: [
          Container(
            color: lightColor, //CHANGE...
            child: SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FlatButton(
                    onPressed: () => Navigator.pop(context),
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    // textColor: foregroundColor,
                    child: Icon(Icons.arrow_back_ios),
                  ),
                  FlatButton(
                    onPressed: () => {},
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    // textColor: foregroundColor,
                    child: ImageIcon(AssetImage(
                      'assets/images/icon-r.png',
                    )),
                  ),
                  FlatButton(
                    onPressed: () => darkModeValue = !(darkModeValue ?? true),
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    // textColor: foregroundColor,
                    child: Opacity(
                      opacity: _iconOpacityAnimation.value,
                      child: ImageIcon(_darkModeToggleIconImage),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 2,
            color: widget.darkModeValue ? Color(0xFF0098A3) : Color(0xFF2B777E),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
