//Isabella Gaytan
//Programming Languages - CS3360
//Exercise: Dart - IO


// import 'package:strategy/strategy.dart' as strategy;
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'dart:io';


// Future<void> main() async {
  
//   stdout.write('Welcome to Omok Game!');
//   stdout.write('\n');
//   var defaultUrl = "https://www.cs.utep.edu/cheon/cs3360/project/omok/info/";
//   stdout.write('Enter the server URL [default: $defaultUrl]');
//   stdout.write('\n');
//   String? url = defaultUrl;

//   // Convert default string url to Uri object
//   var response = await http.get(Uri.parse(url));
//   var info = json.decode(response.body); // used to be json.decode
//   var strategies = info['strategies'];

//   // User input URL
//   var userinput;

//   try {
//     // User input URL
//     var userinput = stdin.readLineSync();
//     url = userinput;
    
//     // Convert user url to Uri object
//     response = await http.get(Uri.parse(url!));  

//     // Retrieve JSON reponse
//     info = json.decode(response.body);    

//     // Store strategies    
//     strategies = info['strategies'];            

//   } catch(e) {
//     print("Invalid input, Please Enter a valid URL");

//     // Reset to Default Value
//     url = "https://www.cs.utep.edu/cheon/cs3360/project/omok/info/";
//     response = await http.get(Uri.parse(url));
//     info = json.decode(response.body);
//     strategies = info['strategies'];
//     userinput = stdin.readLineSync();
//   }
  

//   stdout.write('Using [$url]');
//   stdout.write('\n');
//   stdout.write('Obtaining server information....');
//   stdout.write('\n');

//   // Shows available strategy choices
//   for (int i = 0; i < strategies.length; i++) {
//     var currStrategy = strategies[i];
//     int currIndex = i + 1;
//     stdout.write("$currIndex. $currStrategy ");
//   }
//   int userNum = 1;
//   stdout.write("[default: $userNum] ");

//   // Choice
//   userinput = stdin.readLineSync();
//   while(userinput!.isNotEmpty){
//     try {
//       userNum = int.parse(userinput);
//     } catch(e) {
//       print('\n');
//       print("Invalid selection: {$userNum}");

//       // Reset to default Value
//       userNum = 1; 
//       userinput = stdin.readLineSync();
//       continue;
//     }
//     if ((userNum > strategies.length) || (userNum <= 0)) {
//       int len = strategies.length;
//       print("Invalid selection: {$userNum}, please enter one of the choices! [1 or 2]");

//       userNum = 1; 
//       userinput = stdin.readLineSync();
//       continue;
//     }
//     break;
//   }

//   var chosenStrategy = strategies[userNum-1];
//   stdout.write("Creating a new game, strategy: $chosenStrategy ");
// }



//refactoring old exercise: same thing but better structure,, use design on ppt 
//response parse for json 
import 'package:strategy/strategy.dart' as strategy;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

void main(List<String> arguments){
  Controller().start();
}

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
    //var board = Board(info.size); //split method into 2 or 3 methods
  }
}

class ConsoleUI {
  void showMessage(String msg) {
    stdout.writeln(msg);
  }
  
  //bracket means optional
  promptServer([serverUrl = WebClient.defaultServer]) {
    stdout.write('Enter server URL (default: $serverUrl) ');
    stdout.write('\n');
    //reading one line
    var url = stdin.readLineSync();
    // TODO: ....
    
    // if the user enter invalid url do something and then return url whether it be the default or the entered one
     
    return url;

  }

  promptStrategy(){

  }
}

class WebClient{
  static const defaultServer = 'https://www.cs.utep.edu/cheon/cs3360/project/omok/info/';
  
  var server;
  
  WebClient(this.server);
  
  getInfo() {
    //TODO:.. method connection, json, parse and return 
    var response = ResponseParser(this.server);
    response.parseInfo();
    return Info(15, ['Smart', 'Random']);
  }
}

class ResponseParser{
  var response;

  ResponseParser(this.response);
  
  parseInfo(){
    
  }

}


class Info {
  final List<String> strategies;
  final int size;

  Info(this.size, this.strategies);
}

