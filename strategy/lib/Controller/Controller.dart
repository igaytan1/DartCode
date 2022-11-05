import 'package:strategy/strategy.dart' as strategy;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
class Controller{
  void start(){
    var ui = ConsoleUI();
    ui.showMessage('Welcome to Omok game');

    //ui.promptServer();
    var server = ui.promptServer();

    ui.showMessage('Connecting to the server....');
    var net = WebClient(server);
    var info = net.getInfo(); //returns structure that has size and strategies
    //... prompt user to pick strategy 
    //create board
    var board = Board(info.size); //split method into 2 or 3 methods
  }
}