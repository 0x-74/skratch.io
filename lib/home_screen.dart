import 'package:flutter/material.dart';
import 'package:skratch/create_room_screen.dart';
import 'package:skratch/join_room_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              ("Create/Join a room!"),
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1 ,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => CreateRoomScreen())), child: Text('Create')),
                ElevatedButton(onPressed: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>JoinRoomScreen())), child: Text('Join'))
              ],
            )
          ]),
    );
  }
}
