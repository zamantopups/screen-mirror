 import 'package:flutter/material.dart';
 import 'package:flutter_webrtc/flutter_webrtc.dart';
 import 'package:permission_handler/permission_handler.dart';
 import 'dart:async';

 void main() {
   runApp(MaterialApp(home: ChildMirrorApp()));
 }

 class ChildMirrorApp extends StatefulWidget {
   @override
   _ChildMirrorAppState createState() => _ChildMirrorAppState();
 }

 class _ChildMirrorAppState extends State<ChildMirrorApp> {
   MediaStream? _localStream;
   RTCPeerConnection? _peerConnection;
   String _status = "Ready to Share";
   String _myId = "Connecting...";

   // Note: For a real app, you'd use a signaling server.
   // For this DIY APK, we'll display instructions.

   Future<void> _startScreenShare() async {
     var status = await Permission.storage.request();
     if (await Permission.microphone.request().isGranted) {
       // Permissions granted
     }

     try {
       final Map<String, dynamic> mediaConstraints = {
         'audio': false,
         'video': true,
       };

       // This triggers the Android Screen Recording Notification
       _localStream = await navigator.mediaDevices.getDisplayMedia(mediaConstraints);

       setState(() {
         _status = "Screen Sharing Active!";
       });

       // Logic to connect to Parent would go here via WebRTC
       print("Stream started: ${_localStream!.id}");

     } catch (e) {
       setState(() {
         _status = "Error: $e";
       });
     }
   }

   @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(title: Text("Child Screen Mirror")),
       body: Center(
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             Icon(Icons.monitor, size: 100, color: Colors.blue),
             SizedBox(height: 20),
             Text(_status, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
             SizedBox(height: 30),
             ElevatedButton(
               onPressed: _startScreenShare,
               child: Text("Start Mirroring"),
               style: ElevatedButton.styleFrom(padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15)),
             ),
             Padding(
               padding: const EdgeInsets.all(20.0),
               child: Text(
                 "Note: A notification will appear at the top indicating screen sharing is active as per
         Android policy.",
                 textAlign: TextAlign.center,
                 style: TextStyle(color: Colors.grey, fontSize: 12),
               ),
             )
           ],
         ),
       ),
     );
   }
 }
