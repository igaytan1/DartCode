// author: Isabella Gaytan 
// Omok App
// Board Class - M


import 'dart:io';

class Board{
  final int size;
  var _coordinates;
  

  Board(this.size, this._coordinates);

  static Board generateBoard(size){
    var _coordinates = List.generate(size, (i) => List.filled(size, '.', growable:false),growable:false);  
    return Board(size, _coordinates);

  }

  get coordinates => _coordinates;


  /// Places move on terminal board
  static String placeMove(var ackMove, var serverMove, coordinates, List<dynamic> pastServerMoves){
    String checkStatus = '';
    int x = ackMove['x'];
    int y = ackMove['y'];

    if(coordinates[y][x] == '.'){
      coordinates[y][x] = 'O';

      checkStatus = isWinningOrDrawMove(ackMove, serverMove, coordinates);
      if(checkStatus != 'keep playing'){
        return checkStatus;
      }

      var serverMoveX;
      var serverMoveY;

      /// adding 1 to match terminal coordinates
      serverMoveX = serverMove['x'];
      serverMoveY = serverMove['y'];
     
      /// placing current server move
      coordinates[serverMoveY][serverMoveX] = '*';

      /// add current server moves to past server moves 
      pastServerMoves.add(serverMoveY);
      pastServerMoves.add(serverMoveX);

    }
    else{
      stdout.writeln('That place is taken! Try Again');
    }
    return checkStatus;
  }

  /// Deciphers whether the move causes the game to end in win/loss/draw
  static String isWinningOrDrawMove(var ackMove, var serverMove, coordinates){
    String outcome = 'keep playing'; 

    if(ackMove['isWin'] || serverMove['isWin']){ // Check if player entered winning move 
      List<dynamic> winningRow;
      if(ackMove['isWin']){
        winningRow = ackMove['row'];
        for(int i = 1; i < winningRow.length; i= i+2){
          coordinates[winningRow[i]][winningRow[i-1]] = 'W';
        }
        outcome = 'win';
        return outcome;

      }else{
        winningRow = serverMove['row'];
        for(int i = 1; i < winningRow.length; i= i+2){
          coordinates[winningRow[i]][winningRow[i-1]] = 'L';
        }
        outcome = 'loss';
        return outcome;
      }
    } 

    if(ackMove['isDraw'] || serverMove['isDraw']){ // Check if player entered winning move 
      outcome = 'draw';
    } 
    return outcome;
  }

  /// Replaces past server moves
  static updateServerMoves(List<dynamic> pastServerMoves, coordinates){
    print(pastServerMoves);
    for(int i = 1; i < pastServerMoves.length; i= i+2){
      coordinates[pastServerMoves[i-1]][pastServerMoves[i]] = 'X';
    }
  }
}
