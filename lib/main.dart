import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Color Fill Button',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Color Fill Button Example'),
        ),
        body: Center(
          child: ColorFillButton(),
        ),
      ),
    );
  }
}

class ColorFillButton extends StatefulWidget {
  @override
  _ColorFillButtonState createState() => _ColorFillButtonState();
}

class _ColorFillButtonState extends State<ColorFillButton> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _widthAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );

    _widthAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          print('Успех');
        }
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        _controller.forward();
      },
      onLongPressUp: () {
        _controller.reverse();
      },
      child: Container(
        width: 200,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            AnimatedBuilder(
              animation: _widthAnimation,
              builder: (context, child) {
                return Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: 200 * _widthAnimation.value,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                );
              },
            ),
            Text(
              'Press and Hold',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}