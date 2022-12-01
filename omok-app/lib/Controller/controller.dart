// author: Isabella Gaytan 
// Omok App
// Controller - C

import '../Model/info.dart';
import '../Model/board.dart';
import '../Model/webclient.dart';
import '../View/consoleui.dart';


 void main(List<String> arguments){
  Controller().start();
}

class Controller{
  void start() async{
    var ui = ConsoleUI();
    ui.showMessage('Welcome to Omok game!');

    var server = ui.promptServer();

    /// Connect to the webclient and get information from the server
    var net = WebClient(server);

    /// Get decoded map response from server
    var decodedResponse = await net.getInfo(); //returns structure that has size and strategies

    ui.showMessage('Connecting to the server....');

    /// Provide game info 
    Info info = Info(decodedResponse['size'], decodedResponse['strategies']);

    /// Create board
    var board = Board.generateBoard(info.size);

    /// Prompt user to pick strategy 
    var selectedStrategy = ui.promptStrategy(info.strategies);
    ui.showMessage('\nCreating game....');

    /// Show starting board to user
    ui.showBoard(board.coordinates);
      
    /// Prompt user first move and check if it is valid 
    List<int>? move = ui.promptMove(info.size, board.coordinates);

    /// Send selected strategy to server and return pid 
    var game = await net.getNew(selectedStrategy);
    var pid= game['pid'];

    /// Begin first play and send to play  
    var play = await net.play(pid, move);

    var ack_move = play['ack_move'];  // acknowledgement and the outcome of the requested user mov
    
    var compMove = play['move']; // server move 

    List<dynamic> pastServerMoves = [];
    
    /// Place user first move and server first move on console board
    Board.placeMove(ack_move, compMove, board.coordinates, pastServerMoves);
    

    /// Loop game until server or user wins
    while(true){
      /// Shows board to user
      ui.showBoard(board.coordinates);

      /// Prompt user move and checks if it is valid 
      List<int>? move = ui.promptMove(info.size, board.coordinates);

      /// Continue play and send to play 
      var play = await net.play(pid, move);

      var ack_move = play['ack_move'];  // acknowledgement and the outcome of the requested user move
    
      var compMove = play['move']; // server move 
      Board.updateServerMoves(pastServerMoves, board.coordinates);
      /// Place user and server move on console board and check if move reaches game conclusion
      String gameStatus = Board.placeMove(ack_move, compMove, board.coordinates, pastServerMoves);
      
      if(gameStatus == 'win'){
        ui.showBoard(board.coordinates);
        print('\nYou win!! Yassssssss');
        return;
      }else if(gameStatus == 'loss'){
        ui.showBoard(board.coordinates);
        print('\nYou lose...');
        return;
      }else if(gameStatus == 'draw'){
        ui.showBoard(board.coordinates);
        print('\nYou and the server have reached a tie!!!');
        return;
      }
    }   
  }
}
