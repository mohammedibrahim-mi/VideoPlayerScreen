import 'dart:async';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatefulWidget {

  const VideoScreen({Key? key}) : super(key: key);

  @override
  State<VideoScreen> createState() => _VideoScreenState();


}

class _VideoScreenState extends State<VideoScreen> {


  late VideoPlayerController _controller;
  bool _isMuted = false;

  late Timer _timer;



  int _selectedIndex = 0;



  @override
  void initState() {
    super.initState();

    // _controller = VideoPlayerController.network(
    //   'https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4', // Replace with your video URL
    // )
    _controller = VideoPlayerController.asset('assets/sample.mp4')
      ..initialize().then((_) {
        setState(() {});
        print("swswswsw");
        _controller.play();
      })
      ..setLooping(true);
  }

  @override
  void dispose() {

    _controller.dispose();
    super.dispose();

  }

  void _toggleVolume() {
    setState(() {
      if (_isMuted) {
        _controller.setVolume(1.0);
      } else {
        _controller.setVolume(0.0);
      }
      _isMuted = !_isMuted;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Wallet',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(width: 8),
            Text(
              'Exchange',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
                decoration: TextDecoration.lineThrough, // disabled look
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body:
      //_pages[_selectedIndex],

      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20,),
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  ),
                  Container(
                    height: 45,
                    width: 45,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: FloatingActionButton(
                        onPressed: _toggleVolume,
                        child: Icon(
                          _isMuted ? Icons.volume_off : Icons.volume_up,

                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30,),

            ],
          ),
        ),
      ),

    );
  }
}