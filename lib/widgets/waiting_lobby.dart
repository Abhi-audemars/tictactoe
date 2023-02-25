import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe/provider/room_data_provider.dart';
import 'package:tictactoe/responsive/responsive.dart';
import 'package:tictactoe/widgets/cusstom_text_field.dart';

class WaitingLobby extends StatefulWidget {
  const WaitingLobby({super.key});

  @override
  State<WaitingLobby> createState() => _WaitingLobbyState();
}

class _WaitingLobbyState extends State<WaitingLobby>
    with TickerProviderStateMixin {
  late TextEditingController roomIDController;

  @override
  void initState() {
    super.initState();
    roomIDController = TextEditingController(
        text: Provider.of<RoomDataProvider>(context, listen: false)
            .roomData['_id']);
    print(Provider.of<RoomDataProvider>(context, listen: false)
            .roomData['_id']);
  }

  @override
  void dispose() {
    super.dispose();
    roomIDController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Responsive(
      child: Scaffold(
        body: AnimatedBackground(
          vsync: this,
          behaviour: ChildFlySpaceBehaviour(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Waiting for a palyer to join...',
                style: GoogleFonts.tourney(
                  fontSize: 30,
                ),
              ),
              Lottie.network(
                  'https://assets3.lottiefiles.com/packages/lf20_exozP9.json',
                  width: 180,
                  height: 180),
              const SizedBox(height: 20),
              CustomTextField(
                controller: roomIDController,
                hinttext: '',
                isReadOnly: true,
              ),
              const SizedBox(height: 3),
              Text(
                'Send this ID to your opponent.',
                style: GoogleFonts.tourney(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
