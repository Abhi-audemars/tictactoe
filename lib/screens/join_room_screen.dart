import 'dart:io';

import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe/resources/socket_methods.dart';
import 'package:tictactoe/responsive/responsive.dart';
import 'package:tictactoe/widgets/cusstom_text_field.dart';
import 'package:tictactoe/widgets/custom_button.dart';
import 'package:tictactoe/widgets/custom_text.dart';

class JoinRoomScreen extends StatefulWidget {
  static String routeNmae = '/join-room';
  const JoinRoomScreen({super.key});

  @override
  State<JoinRoomScreen> createState() => _JoinRoomScreenState();
}

class _JoinRoomScreenState extends State<JoinRoomScreen>
    with TickerProviderStateMixin {
  final TextEditingController gameIDcontroller = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void dispose() {
    super.dispose();
    gameIDcontroller.dispose();
    nameController.dispose();
  }

  @override
  void initState() {
    super.initState();
    _socketMethods.joinRoomSuccessListner(context);
    _socketMethods.errorOccuredListner(context);
    _socketMethods.updatePlayersStateListner(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBackground(
        vsync: this,
        behaviour: SpaceBehaviour(),
        child: Responsive(
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CustomText(
                    shadows: [
                      Shadow(
                        blurRadius: 40,
                        color: Colors.white,
                      ),
                    ],
                    text: 'Join Room',
                    fontSize: 70,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                  CustomTextField(
                    controller: nameController,
                    hinttext: 'Enter your nickname',
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    controller: gameIDcontroller,
                    hinttext: 'Enter game ID',
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.3),
                  CustomButton(
                      onTap: () {
                        _socketMethods.joinRoom(
                            nameController.text, gameIDcontroller.text);
                      },
                      text: 'Join')
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
