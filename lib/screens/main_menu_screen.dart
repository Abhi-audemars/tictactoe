import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:tictactoe/responsive/responsive.dart';
import 'package:tictactoe/screens/join_room_screen.dart';
import 'package:tictactoe/utils/utils.dart';
import 'package:tictactoe/widgets/custom_button.dart';
import 'package:animated_background/animated_background.dart';

import 'create_room_screen.dart';

class MainMenuScreen extends StatefulWidget {
  static String routeName = '/main-menu-screen';
  const MainMenuScreen({super.key});

  @override
  State<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBackground(
        vsync: this,
        behaviour: ChildFlySpaceBehaviour(),
        child: Responsive(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('MULTIPLAYER', style: GoogleFonts.tourney(fontSize: 12)),
              Text('TIC-TAC-TOE', style: GoogleFonts.tourney(fontSize: 45)),
              Lottie.network(
                  'https://assets10.lottiefiles.com/packages/lf20_eAqEBOw7m9.json',
                  width: 150,
                  height: 150),
              const SizedBox(height: 25),
              CustomButton(
                onTap: () {
                  Navigator.pushNamed(context, CreateRoomScreen.routeNmae);
                },
                text: 'CREATE ROOM',
              ),
              const SizedBox(height: 25),
              CustomButton(
                onTap: () {
                  Navigator.pushNamed(context, JoinRoomScreen.routeNmae);
                },
                text: 'JOIN ROOM',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
