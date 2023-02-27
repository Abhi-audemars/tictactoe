import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketClient {
  IO.Socket? socket;
  static SocketClient? _instance;

  // 192.168.1.7
  SocketClient._internal() {
    socket = IO.io('https://tictactoe-backend-dx28.onrender.com', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    socket!.connect();
    socket!.onConnect((data) => print('connected'));
  }
  

  static SocketClient get instance {
    _instance ??= SocketClient._internal();
    return _instance!;
  }
}
