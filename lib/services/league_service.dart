import 'dart:convert';

import 'package:desing/models/models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class LeagueService with ChangeNotifier {
  final url = Uri.https('ddragon.leagueoflegends.com', '/cdn/11.10.1/data/es_ES/champion.json');
  Future<List<Campeon>> obtenerChamps() async {
    final res = await http.get(this.url);
    //string to json
    final decode = jsonDecode(res.body);
    final Map data = decode['data'];
    
    List<Campeon> champs = [];
    data.forEach((key, value) {
      champs.add(Campeon.fromJson(value));
    });
    // print(champs[0].info?.attack);
    return champs;
  }

}