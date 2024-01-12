import 'package:flutter/material.dart';

class CountdownTimer extends StatefulWidget {
  final int secondsLeft;
  const CountdownTimer({super.key, required this.secondsLeft});

  @override
  _CountdownTimerState createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  // void _pauseTimer() {
  //   _timer.cancel();
  //   _isRunning = false;
  //   _showStartButton();
  // }

  // void _resetTimer() {
  //   _timer.cancel();
  //   _secondsLeft = 60;
  //   _showStartButton();
  // }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  // void _showStartButton() {
  //   setState(() {
  //     _isRunning = false;
  //   });
  // }

  // void _showPauseResetButtons() {
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        _formatTime(widget.secondsLeft),
        style: const TextStyle(fontSize: 24),
      ),
    );
  }

  // @override
  // void dispose() {
  //   _timer.cancel();
  //   super.dispose();
  // }
}
