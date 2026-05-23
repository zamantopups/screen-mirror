 import 'package:flutter/material.dart';
 import 'package:flutter_webrtc/flutter_webrtc.dart';
 import 'package:permission_handler/permission_handler.dart';

 void main() {
   runApp(MaterialApp(home: ChildMirrorApp()));
 }

 class ChildMirrorApp extends StatefulWidget {
   @override
   _ChildMirrorAppState createState() => _ChildMirrorAppState();
 }

 class _ChildMirrorAppState extends State<ChildMirrorApp> {
   MediaStream? _localStream;
   String _status = "Ready to Share";

   Future<void> _startScreenShare() async {
     await Permission.microphone.request();
     try {
       final Map<String, dynamic> mediaConstraints = {'audio': false, 'video': true};
       _localStream = await navigator.mediaDevices.getDisplayMedia(mediaConstraints);
       setState(() { _status = "Screen Sharing Active!"; });
     } catch (e) {
       setState(() { _status = "Error: $e"; });
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
                 "Note: A notification will appear as per Android policy.",
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
