    1 import 'package:flutter/material.dart';
    2 import 'package:flutter_webrtc/flutter_webrtc.dart';
    3 import 'package:permission_handler/permission_handler.dart';
    4 import 'dart:async';
    5
    6 void main() {
    7   runApp(MaterialApp(home: ChildMirrorApp()));
    8 }
    9
   10 class ChildMirrorApp extends StatefulWidget {
   11   @override
   12   _ChildMirrorAppState createState() => _ChildMirrorAppState();
   13 }
   14
   15 class _ChildMirrorAppState extends State<ChildMirrorApp> {
   16   MediaStream? _localStream;
   17   String _status = "Ready to Share";
   18
   19   Future<void> _startScreenShare() async {
   20     await Permission.microphone.request();
   21     try {
   22       final Map<String, dynamic> mediaConstraints = {
   23         'audio': false,
   24         'video': true,
   25       };
   26       _localStream = await navigator.mediaDevices.getDisplayMedia(mediaConstraints);
   27       setState(() {
   28         _status = "Screen Sharing Active!";
   29       });
   30     } catch (e) {
   31       setState(() {
   32         _status = "Error: $e";
   33       });
   34     }
   35   }
   36
   37   @override
   38   Widget build(BuildContext context) {
   39     return Scaffold(
   40       appBar: AppBar(title: Text("Child Screen Mirror")),
   41       body: Center(
   42         child: Column(
   43           mainAxisAlignment: MainAxisAlignment.center,
   44           children: [
   45             Icon(Icons.monitor, size: 100, color: Colors.blue),
   46             SizedBox(height: 20),
   47             Text(_status, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
   48             SizedBox(height: 30),
   49             ElevatedButton(
   50               onPressed: _startScreenShare,
   51               child: Text("Start Mirroring"),
   52               style: ElevatedButton.styleFrom(padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15)),
   53             ),
   54             Padding(
   55               padding: const EdgeInsets.all(20.0),
   56               child: Text(
   57                 "Note: A notification will appear at the top indicating screen sharing is active as per Android
      policy.",
   58                 textAlign: TextAlign.center,
   59                 style: TextStyle(color: Colors.grey, fontSize: 12),
   60               ),
   61             )
   62           ],
   63         ),
   64       ),
   65     );
   66   }
   67 }
