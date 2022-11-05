// author: Isabella Gaytan and Clarissa Dominguez
// CS: 3360
// Exercise: Dart - MVC 
// Response Parser Class - M

import 'dart:convert';

class ResponseParser{
  static parseInfo(String data){
    return jsonDecode(data);
  }

}