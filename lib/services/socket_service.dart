import 'package:chat_app/globals/enviroment.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus { Connecting, Offline, Online }

class SocketService with ChangeNotifier {
  ServerStatus _statusService = ServerStatus.Connecting;
  IO.Socket _socket;
  

  ServerStatus get statusService => _statusService;

  Function get emit => _socket.emit;

  IO.Socket get socket => _socket;

  void connect() async{
    
    final token = await AuthService.getToken();

    this._socket = IO.io(
        Enviroment.urlSocket,
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .enableForceNew()
            .enableAutoConnect()
            .setExtraHeaders({'x-token': token})
            .build());

    this._socket.onConnect((data) {
      _statusService = ServerStatus.Online;
      notifyListeners();
    });

    this._socket.onDisconnect((data) {
      _statusService = ServerStatus.Offline;
      notifyListeners();
    });

    // socket.on('nuevo-mensaje', (payload){
    //   print(payload.containsKey('mensaje') ? payload['mensaje'] : '');
    // });
  }

  void disconnect() {
    this._socket.disconnect();
  }
}
