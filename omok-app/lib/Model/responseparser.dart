// author: Isabella Gaytan 
// Omok App
// Response Parser Class - M

import 'dart:convert';

class ResponseParser{
  static parseInfo(String data){
    return jsonDecode(data);
  }

}
