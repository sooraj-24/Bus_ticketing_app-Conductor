import 'dart:convert';
import 'package:buts_conductor_app/Model/buses.dart';
import 'package:buts_conductor_app/Model/user.dart';
import 'package:buts_conductor_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AppProvider extends ChangeNotifier {
  String password = '';
  String email = '';
  bool signedIn = false;
  bool isPassVisible = false;
  ViewState state = ViewState.idle;
  String token = '';
  late Buses buses;
  int selectedIndex = -1;
  late List<UserData> userData;
  late String qrCodeResult;
  String code = '';
  String ticketEmail = '';
  String ticketBusId = '';

  void updatePassword(String value){
    password = value;
    notifyListeners();
  }

  void updateEmail(String value){
    email = value;
    notifyListeners();
  }

  void updateState(ViewState value){
    state = value;
    notifyListeners();
  }

  void updateSelectedIndex(int value){
    selectedIndex = value;
    notifyListeners();
  }

  void updateTicketData(String ticketCode, String emailValue, String busId){
    code = ticketCode;
    ticketEmail = emailValue;
    ticketBusId = busId;
    print(code);
    print(ticketEmail);
    print(ticketBusId);
    notifyListeners();
  }

  void togglePasswordVisibility(){
    isPassVisible = !isPassVisible;
    notifyListeners();
  }

  Future<void> login() async {
    state = ViewState.busy;
    notifyListeners();
    http.Response response;
    var url = Uri.parse("https://buts-server.onrender.com/conductor/login");
    var data = {
      "password": password,
      "email": email
    };
    var body = json.encode(data);
    response = await http.post(url,body: body,headers: {
      "Content-Type": "application/json"
    }).catchError((e){
      state = ViewState.error;
      notifyListeners();
      throw Exception(e.toString());
    });
    Map<String,dynamic> output = jsonDecode(response.body);
    if(response.statusCode == 200 && output["message"] == "Logged in Successfully"){
      signedIn = true;
      token = output["data"]["token"];
      state = ViewState.success;
      notifyListeners();
    } else {
      state = ViewState.error;
      notifyListeners();
      throw Exception("${output["message"]}");
    }
  }

  Future<void> getBuses() async {
    http.Response response;
    var url = Uri.parse("https://buts-server.onrender.com/conductor/busdata");
    response = await http.get(url ,headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    }).catchError((e){
      state = ViewState.error;
      notifyListeners();
      throw Exception(e.toString());
    });
    if(response.statusCode == 200){
      buses = busesFromJson(response.body);
      userData = List<UserData>.filled(buses.bus!.length, UserData());
      state = ViewState.success;
      notifyListeners();
    } else {
      state = ViewState.error;
      notifyListeners();
      throw Exception("Error code: ${response.statusCode}");
    }
  }

  Future<void> startSession() async {
    state = ViewState.busy;
    notifyListeners();

    http.Response response;
    var url = Uri.parse("https://buts-server.onrender.com/conductor/startsession");
    var data = {
      "busId": buses.bus?[selectedIndex].id
    };
    var body = json.encode(data);
    response = await http.post(url, body: body ,headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    }).catchError((e){
      state = ViewState.error;
      notifyListeners();
      throw Exception(e.toString());
    });
    print(response.body);
    if(response.statusCode == 200){
      userData[selectedIndex] = userDataFromJson(response.body);
      print("here");
      print(userData.length);
      state = ViewState.success;
      buses.bus?[selectedIndex].sessionStart = true;
      notifyListeners();
    } else {
      state = ViewState.error;
      notifyListeners();
      throw Exception("Error code: ${response.statusCode}");
    }
  }

  Future<bool> scanQR() async {
    state = ViewState.busy;
    notifyListeners();

    http.Response response;
    var url = Uri.parse("https://buts-server.onrender.com/conductor/scanQR");
    var data = {
      "code": int.parse(code),
      "email": ticketEmail,
      "ticketBusId": ticketBusId,
      "sessionBusId": buses.bus?[selectedIndex].id
    };
    var body = json.encode(data);
    response = await http.post(url, body: body ,headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    }).catchError((e){
      state = ViewState.error;
      notifyListeners();
      throw Exception(e.toString());
    });
    print(response.body);
    if(response.statusCode == 200){
      state = ViewState.success;
      notifyListeners();
      return true;
    } else {
      state = ViewState.error;
      notifyListeners();
      throw Exception("Scan failed. Error code: ${response.statusCode}");
    }
  }
}