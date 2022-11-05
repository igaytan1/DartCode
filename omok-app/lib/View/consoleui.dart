// author: Isabella Gaytan and Clarissa Dominguez
// CS: 3360
// Exercise: Dart - MVC 
// ConsoleUI Class - V

import 'dart:io';
import '../Model/webclient.dart';

class ConsoleUI {
  void showMessage(String msg) {
    stdout.writeln(msg);
  }
  
  //bracket means optional
  promptServer([serverUrl = WebClient.defaultServer]) {
    stdout.writeln('Enter server URL or \'Enter\' for (default: $serverUrl): ');
    
    //reading one line
    var url = stdin.readLineSync();

    // if the user enter invalid url do something and then return url whether it be the default or the entered one
    if(url == null || url.isEmpty == true){
      return serverUrl;
    }
     
    return url;

  }

  // Displays strategy choices  
  promptStrategy(List<dynamic> strategies){
    stdout.writeln('Select the server strategy: ');
    for(int i = 0; i < strategies.length; i++){
      stdout.writeln('${i+1})  ${strategies[i]}');
    }

    int strategySelected = 0;

    // Checks for invalid input and handles
    while(strategySelected < 1 || strategySelected > strategies.length){
      try{
        var line = stdin.readLineSync();
        strategySelected = int.parse(line ?? '0');
        if(strategySelected < 1 || strategySelected > strategies.length){
          stdout.writeln('Invalid Selection. Try again!');
        }
      }on FormatException catch(_,e){
        stdout.write(e);
        stdout.writeln('Wrong Input! Please input a number between 1 - ${strategies.length}');
      }
    }
    return strategies[strategySelected-1];

  }

  List<int>? promptMove(size, coordinates){

    while(true){
      stdout.writeln('Enter x and y (1-15, e.g., 8 10)');
      var lineIn = stdin.readLineSync() ?? "";
      List<int>? move; 
      int xIndex;
      int yIndex;

      try{
        List<String>? splitLine = lineIn.split(' ');
        int xIndex;
        int yIndex;
        if(splitLine.length == 2){
          yIndex = int.parse(splitLine[0]);
          xIndex = int.parse(splitLine[1]);
          if((xIndex > size || xIndex < 1) || (yIndex > size || yIndex < 1)){
            stdout.write('Invalid index! Try again\n');
          }
          if(coordinates[yIndex-1][xIndex-1] != '.'){
            stdout.writeln('That place is taken! Try Again');
          }else{
            move = [yIndex-1, xIndex-1];
            return move;
          }
        }else{
          stdout.write('Invalid index! Try again\n');
        }
        
      }catch (e){
        stdout.writeln('Invalid index! try again\n');
      }
    }
  }

  void showBoard(var coordinates){
    var indexes = List<int>.generate(coordinates.length, (i) => (i + 1) %10).join(' ');
    stdout.writeln(' x $indexes');
    stdout.write('y ');
    for(var underline = 0; underline < coordinates.length; underline++){
      stdout.write('--');
    }

    stdout.writeln();
    // Prints rows 
    for(int i = 0; i <coordinates.length; i++){
      stdout.write('${(i + 1) % 10}| ');
      stdout.writeln(coordinates[i].join(" "));
    }

  }
}