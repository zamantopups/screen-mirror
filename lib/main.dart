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
      17   RTCPeerConnection? _peerConnection;
      18   String _status = "Ready to Share";
      19   String _myId = "Connecting...";
      20
      21   // Note: For a real app, you'd use a signaling server.
      22   // For this DIY APK, we'll display instructions.
      23
      24   Future<void> _startScreenShare() async {
      25     var status = await Permission.storage.request();
      26     if (await Permission.microphone.request().isGranted) {
      27       // Permissions granted
      28     }
      29
      30     try {
      31       final Map<String, dynamic> mediaConstraints = {
      32         'audio': false,
      33         'video': true,
      34       };
      35
      36       // This triggers the Android Screen Recording Notification
      37       _localStream = await navigator.mediaDevices.getDisplayMedia(mediaConstraints);
      38
      39       setState(() {
      40         _status = "Screen Sharing Active!";
      41       });
      42
      43       // Logic to connect to Parent would go here via WebRTC
      44       print("Stream started: ${_localStream!.id}");
      45
      46     } catch (e) {
      47       setState(() {
      48         _status = "Error: $e";
      49       });
      50     }
      51   }
      52
      53   @override
      54   Widget build(BuildContext context) {
      55     return Scaffold(
      56       appBar: AppBar(title: Text("Child Screen Mirror")),
      57       body: Center(
      58         child: Column(
      59           mainAxisAlignment: MainAxisAlignment.center,
      60           children: [
      61             Icon(Icons.monitor, size: 100, color: Colors.blue),
      62             SizedBox(height: 20),
      63             Text(_status, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      64             SizedBox(height: 30),
      65             ElevatedButton(
      66               onPressed: _startScreenShare,
      67               child: Text("Start Mirroring"),
      68               style: ElevatedButton.styleFrom(padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15)),
      69             ),
      70             Padding(
      71               padding: const EdgeInsets.all(20.0),
      72               child: Text(
      73                 "Note: A notification will appear at the top indicating screen sharing is active as per
         Android policy.",
      74                 textAlign: TextAlign.center,
      75                 style: TextStyle(color: Colors.grey, fontSize: 12),
      76               ),
      77             )
      78           ],
      79         ),
      80       ),
      81     );
      82   }
      83 }
