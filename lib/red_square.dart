import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RedSquare extends StatefulWidget {
  const RedSquare({super.key});

  @override
  State<RedSquare> createState() => RedSquareState();
}

class RedSquareState extends State<RedSquare> {

  Alignment currentposition = Alignment.center;
  bool isMoving = false;

  //make sure the butttons are active only when the square is not moving and not at the edge
  bool get leftbuttonactive => !isMoving && currentposition != Alignment.centerLeft;
  bool get rightbuttonactive => !isMoving && currentposition != Alignment.centerRight;

  //when called the square will move to the left
  void handleLeftMove() {
    if (!leftbuttonactive) return;
    setState(() {
      isMoving = true;
      currentposition = Alignment.centerLeft;
    });
  }

  //when called the square will move to the right
  void handleRightMove() {
    if (!rightbuttonactive) return;
    setState(() {
      isMoving = true;
      currentposition = Alignment.centerRight;
    });
  }

  //when the animation is complete, the square will stop moving
  void handleAnimationComplete() {
    setState(() {
      isMoving = false;
    });
  }

  //reset the square to the center
  void resetPosition() {
    setState(() {
      currentposition = Alignment.center;
    });
  }

  //create a button widget for the control buttons
  Widget controlbutton(String label, VoidCallback action, bool isActive) {
    return CupertinoButton(
      disabledColor: Colors.grey,
      onPressed: isActive ? action : null,
      color: Colors.black87,
      child: Text(label, style: const TextStyle(color: Colors.white)),
    );
  }

  //create a widget for the animated square
  Widget AnimatedSquare() {
    return AnimatedAlign(
      alignment: currentposition,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOutCubic,
      onEnd: handleAnimationComplete,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.redAccent[400],
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 6,
              offset: const Offset(2, 4),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[350],
      appBar: AppBar(
        title: const Text('Red Square Navigator', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.grey[850],
        actions: [
          IconButton(
            icon: const Icon(Icons.replay, size: 26),
            color: Colors.white,
            onPressed: resetPosition,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: AnimatedSquare(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 32.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                controlbutton('to left', handleLeftMove, leftbuttonactive,),
                controlbutton('to  right', handleRightMove, rightbuttonactive),
              ],
            ),
          ),
        ],
      ),
    );
  }
}