import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tictactoe/resources/socket_client.dart';
import 'package:tictactoe/resources/socket_methods.dart';
import 'package:tictactoe/responsive/responsive.dart';
import 'package:tictactoe/screens/game_screen.dart';
import 'package:tictactoe/widgets/cusstom_text_field.dart';
import 'package:tictactoe/widgets/custom_button.dart';
import 'package:tictactoe/widgets/custom_text.dart';

class CreateRoomScreen extends StatefulWidget {
  static String routeNmae = '/create-room';
  const CreateRoomScreen({super.key});

  @override
  State<CreateRoomScreen> createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends State<CreateRoomScreen>
    with TickerProviderStateMixin {
  final SocketMethods _socketMethods = SocketMethods();

  final TextEditingController nameController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
  }

  @override
  void initState() {
    _socketMethods.createRoomSuccessListner(context);
    super.initState();
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
                    text: 'Create Room',
                    fontSize: 70,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                  CustomTextField(
                      controller: nameController,
                      hinttext: 'Enter your nickname'),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.42),
                  CustomButton(
                      onTap: () =>
                          _socketMethods.createRoom(nameController.text),
                      text: 'Create')
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
