// author: Isabella Gaytan 
// Omok App
// WebClient Class - M

import 'package:http/http.dart' as http;
import './responseparser.dart';

class WebClient{
  static const defaultServer = 'https://www.cs.utep.edu/cheon/cs3360/project/omok/info/';
  
  var server;
  
  WebClient(this.server);
  
  getInfo() async {
    //TODO:.. method connection, json, parse and return 
    try{
      var serverUri = Uri.parse(server);
      var response = await http.get(serverUri);
      var info = ResponseParser.parseInfo(response.body);
      return info;
    }catch(e){
      print('\nUnable to connect to specified server. Using default server...\n');
      server = defaultServer;
      var serverUri = Uri.parse(server);
      var response = await http.get(serverUri);
      var info = ResponseParser.parseInfo(response.body);
      return info;
    }
  }


  // get new game
  getNew(String selectedStrategy) async {
    try{
      var url = 'https://www.cs.utep.edu/cheon/cs3360/project/omok/new/';
      var uri = Uri.parse('$url?strategy=$selectedStrategy');
      var response = await http.get(uri);
      var statusCode = response.statusCode;
      if(statusCode  < 200 || statusCode > 400){
        print('Server connection failed ($statusCode).');
      }else{
        print('Response body: ${response.body}');
      }
      var game = ResponseParser.parseInfo(response.body);
      return game;
    }on FormatException catch(_,e){
      return null;
    }

  }

  // play 
  play(String pid, List<int>? move) async {
    try{
      int x = move![0];
      int y = move[1];
      String comma = ',';

      var url = 'https://www.cs.utep.edu/cheon/cs3360/project/omok/play/';
      var uri = Uri.parse('$url?pid=$pid&move=$x$comma$y');
      var response = await http.get(uri);
      var statusCode = response.statusCode;
  
      if(statusCode < 200 || statusCode > 400){
        print('Server connection failed ($statusCode.');
      }else{
        print('Response body: ${response.body}');
      }
      var play = ResponseParser.parseInfo(response.body);
      return play;
    }on FormatException catch(_,e){
      return null;
    }
  }
   
}
