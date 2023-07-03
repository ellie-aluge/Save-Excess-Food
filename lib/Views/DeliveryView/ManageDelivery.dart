import 'package:flutter/material.dart';
import 'dart:ui';


class SlideUpPage extends StatefulWidget {
  @override
  _SlideUpPageState createState() => _SlideUpPageState();
}

class _SlideUpPageState extends State<SlideUpPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _animation;

  bool _isPageVisible = false;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    _animation = Tween<Offset>(
      begin: Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(_animationController);

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _togglePageVisibility() {
    setState(() {
      _isPageVisible = !_isPageVisible;
    });

    if (_isPageVisible) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Slide-up Page'),
      ),
      body: Stack(
        children: [
          Container(
            color: Colors.blue,
            width: double.infinity,
            height: double.infinity,
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              color: Colors.transparent,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SlideTransition(
                  position: _animation,
                  child: Container(
                    color: Colors.white,
                    height: MediaQuery.of(context).size.height / 2,
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        'Half Screen Content',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _togglePageVisibility,
        child: Icon(Icons.arrow_upward),
      ),
    );
  }
}
