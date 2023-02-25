import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:tictactoe/provider/room_data_provider.dart';
import 'package:tictactoe/resources/game_methods.dart';
import 'package:tictactoe/resources/socket_client.dart';
import 'package:tictactoe/screens/game_screen.dart';
import 'package:tictactoe/screens/main_menu_screen.dart';
import 'package:tictactoe/utils/utils.dart';

class SocketMethods {
  final _socketClient = SocketClient.instance.socket!;

  Socket get socketClient => _socketClient;

  void createRoom(String nickname) {
    if (nickname.isNotEmpty) {
      _socketClient.emit('createRoom', {
        'nickname': nickname,
      });
    }
  }

  void joinRoom(String nickname, String roomID) {
    if (nickname.isNotEmpty && roomID.isNotEmpty) {
      _socketClient.emit('joinRoom', {
        'nickname': nickname,
        'roomID': roomID,
      });
    }
  }

  void createRoomSuccessListner(BuildContext context) {
    _socketClient.on("roomCreateSuccess", (room) {
      Provider.of<RoomDataProvider>(context, listen: false)
          .updateRoomData(room);
      Navigator.pushNamed(context, GameScreen.routeName);
    });
  }

  void joinRoomSuccessListner(BuildContext context) {
    _socketClient.on("joinRoomSuccess", (room) {
      Provider.of<RoomDataProvider>(context, listen: false)
          .updateRoomData(room);
      Navigator.pushNamed(context, GameScreen.routeName);
    });
  }

  void errorOccuredListner(BuildContext context) {
    _socketClient.on('errorOccured', (data) {
      showSnackBar(context, data);
    });
  }

  void updatePlayersStateListner(BuildContext context) {
    _socketClient.on('updatePlayers', (playerData) {
      Provider.of<RoomDataProvider>(context, listen: false)
          .updatePlayer1(playerData[0]);
      Provider.of<RoomDataProvider>(context, listen: false)
          .updatePlayer2(playerData[1]);
    });
  }

  void updateRoomListners(BuildContext context) {
    _socketClient.on('updateRoom', (data) {
      Provider.of<RoomDataProvider>(context, listen: false)
          .updateRoomData(data);
    });
  }

  void tapGrid(int index, String roomID, List<String> displayElements) {
    if (displayElements[index] == '') {
      _socketClient.emit('tap', {
        'index': index,
        'roomID': roomID,
      });
    }
  }

  void tappedListners(BuildContext context) {
    _socketClient.on('tapped', (data) {
      Provider.of<RoomDataProvider>(context, listen: false)
          .updateDisplayElements(
        data['index'],
        data['choice'],
      );
      Provider.of<RoomDataProvider>(context, listen: false)
          .updateRoomData(data['room']);
      GameMethods().checkWinner(context, socketClient);
    });
  }

  void pointsIncreaseListner(BuildContext context) {
    _socketClient.on('pointsIncrease', (playerData) {
      var roomDataProvider =
          Provider.of<RoomDataProvider>(context, listen: false);
      if (playerData['socketID'] == roomDataProvider.player1.socketID) {
        roomDataProvider.updatePlayer1(playerData);
      } else {
        roomDataProvider.updatePlayer2(playerData);
      }
    });
  }

  void endGameListner(BuildContext context) {
    _socketClient.on('endGame', (playerData) {
      // gameDialogBox(context, '${playerData['nickname']} won the game!');
      // Navigator.of(context).pushNamedAndRemoveUntil(MainMenuScreen.routeName, (route) => false);

      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('${playerData['nickname']} won the game!'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        MainMenuScreen.routeName, (route) => false);
                  },
                  child: Text(
                    'Play next round',
                    style: GoogleFonts.tourney(fontSize: 12),
                  ),
                )
              ],
            );
          });
    });
  }
}
