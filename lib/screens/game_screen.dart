import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe/provider/room_data_provider.dart';
import 'package:tictactoe/resources/socket_methods.dart';
import 'package:tictactoe/widgets/score_board.dart';
import 'package:tictactoe/widgets/tictactoe_board.dart';
import 'package:tictactoe/widgets/waiting_lobby.dart';

class GameScreen extends StatefulWidget {
  static String routeName = '/game';
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    super.initState();
    _socketMethods.updateRoomListners(context);
    _socketMethods.pointsIncreaseListner(context);
    _socketMethods.endGameListner(context);
    _socketMethods.updatePlayersStateListner(context);
  }

  @override
  Widget build(BuildContext context) {
    RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(context);
    return Scaffold(
      body: 
      roomDataProvider.roomData['isJoin']
          ? const WaitingLobby()
          : 
          SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const ScoredBoard(),
                  const TicTacToeBoard(),
                  Text(
                      '${roomDataProvider.roomData['turn']['nickname']}\'s turn',style: GoogleFonts.tourney(
                        color: Colors.white
                      ),)
                ],
              ),
            ),
    );
  }
}
