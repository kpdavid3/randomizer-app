import 'dart:async';
import 'package:flutter/material.dart';

class CountdownApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: CountdownTimer(),
      ),
    );
  }
}

class CountdownTimer extends StatefulWidget {
  @override
  _CountdownTimerState createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  late Timer _timer;
  int _secondsLeft = 60;
  bool _isRunning = false;

  @override
  void initState() {
    super.initState();
  }

  void _updateTimer(Timer timer) {
    if (_secondsLeft > 0 && _isRunning) {
      setState(() {
        _secondsLeft--;
      });
    } else {
      _timer.cancel();
      _isRunning = false;
      _showStartButton();
    }
  }

  void _startTimer() {
    _isRunning = true;
    _timer = Timer.periodic(const Duration(seconds: 1), _updateTimer);
    _showPauseResetButtons();
  }

  void _pauseTimer() {
    _timer.cancel();
    _isRunning = false;
    _showStartButton();
  }

  void _resetTimer() {
    _timer.cancel();
    _secondsLeft = 60;
    _showStartButton();
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  void _showStartButton() {
    setState(() {
      _isRunning = false;
    });
  }

  void _showPauseResetButtons() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _formatTime(_secondsLeft),
            style: TextStyle(fontSize: 64),
          ),
          SizedBox(height: 20),
          if (!_isRunning)
            ElevatedButton(
              onPressed: _startTimer,
              child: Text('Start'),
            ),
          if (_isRunning)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _pauseTimer,
                  child: Text('Pause'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _resetTimer,
                  child: Text('Reset'),
                ),
              ],
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}

void main() {
  runApp(CountdownApp());
}
