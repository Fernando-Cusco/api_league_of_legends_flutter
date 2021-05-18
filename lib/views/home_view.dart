import 'package:desing/models/models.dart';
import 'package:desing/services/league_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:ui';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lol'),),
      body: Container(
        alignment: Alignment.topCenter,
        padding: EdgeInsets.only(top: 20),
        child: Container(
            child: _cargarChamps(context),
          ),
      ),
    );
  }
  
  _cargarChamps(BuildContext context) {
    final service = Provider.of<LeagueService>(context);
    return FutureBuilder(
      future: service.obtenerChamps(),
      builder: (_, AsyncSnapshot<List<Campeon>> snapshot) {
        if (snapshot.hasData) {
          final campeones = snapshot.data;
          return ListView(
            children: (campeones != null)? campeones.map<Widget>((campeon) {
              return header(context, campeon);
            }).toList(): []
          ); 
        } else {
          return CircularProgressIndicator();
        }
     }
    );
  }

  Widget header(BuildContext context, Campeon campeon) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width * 0.7,
      height: 300,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.black,
            Colors.black,
          ],
          tileMode: TileMode.mirror
        ),
        borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      child: Column(
        children: [
          container(context, campeon),
          Container(
            padding: EdgeInsets.only(top: 10, left: 10),
            alignment: Alignment.centerLeft,
            child: Text('Info', style: TextStyle(color: Colors.white)),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Text(campeon.blurb,
                style: TextStyle(color: Colors.white, fontSize: 10),
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                textDirection: TextDirection.ltr,
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 10, left: 10, bottom: 10),
            alignment: Alignment.centerLeft,
            child: Text('Caractetisticas', style: TextStyle(color: Colors.white)),
          ),
          Container(
            padding: EdgeInsets.only(left: 10),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Chip(label: Text('Ataque: ${campeon.info?.attack}')),
                  Chip(label: Text('Defensa: ${campeon.info?.defense}')),
                  Chip(label: Text('Magia: ${campeon.info?.magic}')),
                  Chip(label: Text('Dificultad: ${campeon.info?.difficulty}')),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget container(BuildContext context, Campeon campeon) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.7,
      height: 120,
      decoration: BoxDecoration(
       gradient: LinearGradient(
        colors: [
          Color(0xFFFF4D4D),
          Color(0xFF902929),
          Color(0xFF591A1A),
        ],
        begin: FractionalOffset(0, 0),
        end: FractionalOffset(1, 0),
        tileMode: TileMode.decal
      ),
      borderRadius: BorderRadius.only(bottomRight: Radius.circular(45), topLeft: Radius.circular(20), topRight: Radius.circular(20))
    ),
    child: content(campeon),
  );
  }

  Widget content(Campeon campeon) {
    final textStyle = TextStyle(color: Colors.white);
    return Container(
      alignment: Alignment.bottomCenter,
      child: Container(
        child: Row(
          children: [
            ClipRect(
              child: Align(
                alignment: Alignment.centerLeft,
                // child: Image(image: NetworkImage('http://ddragon.leagueoflegends.com/cdn/img/champion/loading/Aatrox_0.jpg'), height: 120),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 10, top: 30),
              child: Column(
                children: [
                  Text(campeon.title, style: textStyle,),
                  SizedBox(height: 10,),
                  Text(campeon.name, style: textStyle,) 
                ],
              )
            )
          ],
        ),
      )
    );
  }

}