import 'package:flutter/material.dart';
import 'package:skratch/paint_screen.dart';
import 'package:skratch/widgets/custom_text_field.dart';

class JoinRoomScreen extends StatefulWidget {
  const JoinRoomScreen({super.key});

  @override
  State<JoinRoomScreen> createState() => _JoinRoomScreenState();
}

class _JoinRoomScreenState extends State<JoinRoomScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _roomNameController = TextEditingController();

  void joinRoom(){
    if (_nameController.text.isNotEmpty&&_roomNameController.text.isNotEmpty){
      Map data=({
        "nickname":_nameController.text,
        "roomname":_roomNameController.text,
      });
      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PaintScreen(screenFrom: 'joinRoom', data: data)));
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Text('Join Room'),
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.08,
      ),
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: CustomTextField(
          controller: _nameController,
          hintText: 'enter name',
        ),
      ),
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: CustomTextField(
          controller: _roomNameController,
          hintText: 'enter room name',
        ),
      ),
      ElevatedButton(onPressed: joinRoom, child: Text('Join game'))
     
    ]));
  }
}
