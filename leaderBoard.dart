import 'dart:ui';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:golfguidescorecard/models/postTorneo.dart';
import 'package:golfguidescorecard/scoresCard/tablaResultadosSF.dart';
import 'package:golfguidescorecard/scoresCard/torneo.dart';
import 'package:golfguidescorecard/services/db-api.dart';
import 'package:golfguidescorecard/utilities/display-functions.dart';
import 'package:golfguidescorecard/utilities/user-funtions.dart';
import 'package:page_transition/page_transition.dart';

class Leaderboard extends StatefulWidget {
  final int idTorneo;
  Leaderboard({@required this.idTorneo}) : super();

  final String title = "Data Table Flutter Demo";

  @override
  LeaderboardState createState() => LeaderboardState(idTorneo: idTorneo);
}

class LeaderboardState extends State<Leaderboard> {
  PostTorneo _postTorneoLD = null;
  List<PostLeaderboard> _postJuagdoresLeaderboard = [];
  List<PostLeaderboard> selectedPJuagdoresL;
  bool sort;
  int _idTorneo = 0;
  String _subTitulo = '';

  bool _flagClickResultado=false;

  LeaderboardState({int idTorneo}) {
    _idTorneo = idTorneo;
  }

  @override
  initState() {
    super.initState();
    sort = false;
    selectedPJuagdoresL = [];
    _getTorneo();
    _getPostLeaderboard();
  }

  onSortColumTee(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      if (ascending) {
        _postJuagdoresLeaderboard
            .sort((a, b) => a.tee_color.compareTo(b.tee_color));
      } else {
        _postJuagdoresLeaderboard
            .sort((a, b) => b.tee_color.compareTo(a.tee_color));
      }
    }
  }

  onSortColum(int columnIndex, bool ascending) {
    if (columnIndex == 1) {
      if (ascending) {
        _postJuagdoresLeaderboard
            .sort((a, b) => a.nombre_juga.compareTo(b.nombre_juga));
      } else {
        _postJuagdoresLeaderboard
            .sort((a, b) => b.nombre_juga.compareTo(a.nombre_juga));
      }
    }
  }

  onSortColumHcp(int columnIndex, bool ascending) {
    if (columnIndex == 2) {
      if (ascending) {
        _postJuagdoresLeaderboard
            .sort((a, b) => a.hcp_torneo.compareTo(b.hcp_torneo));
      } else {
        _postJuagdoresLeaderboard
            .sort((a, b) => b.hcp_torneo.compareTo(a.hcp_torneo));
      }
    }
  }

  onSortColumMP(int columnIndex, bool ascending) {
    if (columnIndex == 3) {
      if (ascending) {
        _postJuagdoresLeaderboard.sort((a, b) => a.neto.compareTo(b.neto));
      } else {
        _postJuagdoresLeaderboard.sort((a, b) => b.neto.compareTo(a.neto));
      }
    }
  }

  onSortColumST(int columnIndex, bool ascending) {
    if (columnIndex == 4) {
      _postJuagdoresLeaderboard
          .sort((a, b) => b.stableford.compareTo(a.stableford));
      //}
    }
  }

  onSelectedRow(bool selected, PostLeaderboard jugador) async {
    /// NOTA PODEMOS LLAMAR EL RESULTADOS (TAJETA);

  }

  deleteSelected() async {
    setState(() {
      if (selectedPJuagdoresL.isNotEmpty) {
        List<PostLeaderboard> temp = [];
        temp.addAll(selectedPJuagdoresL);
        for (PostLeaderboard jugador in temp) {
          _postJuagdoresLeaderboard.remove(jugador);
          selectedPJuagdoresL.remove(jugador);
        }
      }
    });
  }


  SingleChildScrollView dataBody() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        alignment: Alignment.center,
        child: DataTable(
          dividerThickness: 2,
          dataRowHeight: 50,
          headingRowHeight: 35,
          horizontalMargin: 15,
          sortAscending: sort,
          sortColumnIndex: 0,
          columnSpacing: 2,
          showCheckboxColumn: false,
          columns: [
            DataColumn(
                label: Text(
                  "Tee",
                  style: TextStyle(
                      fontFamily: 'DIN Condensed',
                      fontSize: 20,
                      color: Colors.redAccent),
                  textAlign: TextAlign.center,
                  textScaleFactor: 1,
                ),
                numeric: false,
                tooltip: "Tee",
                onSort: (columnIndex, ascending) {
                  setState(() {
                    sort = !sort;
                  });
                  onSortColumTee(columnIndex, ascending);
                }),
            //   label: Column(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       GestureDetector(
            //         child: Container(
            //             alignment: Alignment.topCenter,
            //             height: 20,
            //             width: 25,
            //             child: Image.asset('assets/tees/estrella.png',
            //                 fit: BoxFit.fill)),
            //         onTap: () {},
            //       ),
            //       Container(
            //         height: 8,
            //       ),
            //     ],
            //   ),
            //   tooltip: "Favoritos",
            // ),
            DataColumn(
                label: Text(
                  "Jugadores",
                  style: TextStyle(
                      fontFamily: 'DIN Condensed',
                      fontSize: 20,
                      color: Colors.redAccent),
                  textAlign: TextAlign.center,
                  textScaleFactor: 1,
                ),
                numeric: false,
                tooltip: "Nombre y Apeliido",
                onSort: (columnIndex, ascending) {
                  setState(() {
                    sort = !sort;
                  });
                  onSortColum(columnIndex, ascending);
                }),
            DataColumn(
                label: Container(
                  // alignment: Alignment.center,
                  child: Text("Hcp",
                      style: TextStyle(
                          fontFamily: 'DIN Condensed',
                          fontSize: 20,
                          color: Colors.redAccent),
                      // textAlign: TextAlign.left,
                      textScaleFactor: 1),
                ),
                numeric: true,
                tooltip: "Handicap de Juego",
                onSort: (columnIndex, ascending) {
                  setState(() {
                    sort = !sort;
                  });
                  onSortColumHcp(columnIndex, ascending);
                }),
            DataColumn(
                label: Expanded(
                  child: Text('MP',
                      style: TextStyle(
                          fontFamily: 'DIN Condensed',
                          fontSize: 20,
                          color: Colors.redAccent),
                      // textAlign: TextAlign.center,
                      textScaleFactor: 1),
                ),
                numeric: true,
                tooltip: "Medal Play",
                onSort: (columnIndex, ascending) {
                  setState(() {
                    sort = !sort;
                  });
                  onSortColumMP(columnIndex, ascending);
                }),
            DataColumn(
                label: Expanded(
                  child: Text(
                    "ST",
                    style: TextStyle(
                        fontFamily: 'DIN Condensed',
                        fontSize: 20,
                        color: Colors.redAccent),
                    textAlign: TextAlign.center,
                    textScaleFactor: 1,
                  ),
                ),
                numeric: true,
                tooltip: "Stableford",
                onSort: (columnIndex, ascending) {
                  setState(() {
                    sort = !sort;
                  });
                  onSortColumST(columnIndex, ascending);
                }),
            DataColumn(
              label: Text(
                "Hoyo",
                style: TextStyle(
                    fontFamily: 'DIN Condensed',
                    fontSize: 20,
                    color: Colors.redAccent),
                textAlign: TextAlign.center,
                textScaleFactor: 1,
              ),
              numeric: true,
              tooltip: "Hoyo en Juego",
            ),
          ],
          rows: _postJuagdoresLeaderboard
              .map(
                (jugador) => DataRow(
                selected: selectedPJuagdoresL.contains(jugador),
                onSelectChanged: (b) {
                  print("Onselect");
                  onSelectedRow(b, jugador);
                },
                cells: [
                  DataCell(
                    Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: UserFunctions.resolverColorTee(
                            jugador.tee_color), //Color(0xFF1f2f50),
                        //UserFunctions.resolverColorTee(jugador.path_tee_color),
                        border:
                        Border.all(color: Colors.black, width: 0.3),
                      ),
                      //child: Text(jugador.tee),
                    ),
                  ),
                  //   GestureDetector(
                  //     child: Container(
                  //         alignment: Alignment.topCenter,
                  //         height: 20,
                  //         width: 25,
                  //         child: Image.asset('assets/tees/estrella2.png',
                  //             fit: BoxFit.fill)),
                  //     onTap: () {},
                  //   ),
                  // ),
                  DataCell(
                    Row(
                      children: <Widget>[
                        // Container(
                        //   height: 30,
                        //   width: 5,
                        //   decoration: BoxDecoration(
                        //     color: UserFunctions.resolverColorTee(
                        //         jugador.tee_color), //Color(0xFF1f2f50),
                        //     //UserFunctions.resolverColorTee(jugador.path_tee_color),
                        //     border:
                        //         Border.all(color: Colors.black, width: 0.3),
                        //   ),
                        //
                        //   //child: Text(jugador.tee),
                        // ),
                        // Container(
                        //   width: 5,
                        // ),
                        CircleAvatar(
                          radius: 15,
                          backgroundImage:
                          NetworkImage(jugador.images.trim() ?? ''),
                          backgroundColor: Colors.black,
                        ),
                        Container(
                          width: 5,
                        ),
                        Expanded(
                          child: Container(
                            height: 20,
                            child: Text(
                              jugador.nombre_juga.toUpperCase(),
                              style: TextStyle(
                                  fontFamily: 'DIN Condensed',
                                  fontSize: 20,
                                  color: Colors.black),
                              textScaleFactor: 1,
                              overflow: TextOverflow.clip,
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      print('Selected ${jugador.nombre_juga}');

                      _llamarResultados(context, jugador);

                    },
                  ),
                  DataCell(
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          jugador.hcp_torneo.toString(),
                          style: TextStyle(
                              fontFamily: 'DIN Condensed',
                              fontSize: 20,
                              color: Colors.blue),
                          textAlign: TextAlign.center,
                          textScaleFactor: 1,
                        ),
                      ],
                    ),
                  ),
                  DataCell(
                    Container(
                      width: 40,
                      height: 100,
                      color: Colors.black,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            UserFunctions.scoreLBNeto(
                                jugador.neto, jugador.status_med),
                            style: TextStyle(
                                fontFamily: 'DIN Condensed',
                                fontSize: 25,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                            textScaleFactor: 1,
                          ),
                        ],
                      ),
                    ),
                  ),
                  DataCell(
                    Container(
                      width: 40,
                      height: 100,
                      color: Colors.lightBlue,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            UserFunctions.scoreLBSta(
                                jugador.stableford, jugador.status_sta),
                            style: TextStyle(
                                fontFamily: 'DIN Condensed',
                                fontSize: 25,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                            textScaleFactor: 1,
                          ),
                        ],
                      ),
                    ),
                  ),
                  DataCell(
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          UserFunctions.scoreLBHoyo(
                              jugador.hoyos_terminados, jugador.state_play),
                          style: TextStyle(
                              fontFamily: 'DIN Condensed',
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                          textScaleFactor: 1,
                          textAlign: TextAlign.right,
                        ),
                      ],
                    ),
                  ),
                ]),
          )
              .toList(),
        ),),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE1E1E1),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(280),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _localStack(),
              Container(
                padding: EdgeInsets.only(top: 5, left: 15, right: 15),
                alignment: Alignment.center,
                child: Text(
                  _subTitulo.toUpperCase(),
                  textAlign: TextAlign.left,
                  textScaleFactor: 1,
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 5, left: 15, right: 15),
                alignment: Alignment.center,
                color: Colors.black,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Power by ',
                      style: TextStyle(color: Colors.white, fontSize: 10),
                      textScaleFactor: 1,
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 3, bottom: 3),
                      height: 35,
                      child: Image.network('http://scoring.com.ar/app/images/publi/scoringpro/leaderboard.jpg', fit: BoxFit.fitHeight,),
                    ),
                  ],
                ),
              ),
              Container(
                color: Colors.grey,
                padding: EdgeInsets.only(top: 5, left: 15, right: 15, bottom: 5),
                alignment: Alignment.center,
                child: Text(
                  'MP: Medal/Stroke Play | ST: Stableford',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                  textScaleFactor: 1,
                ),
              ),
              Container(
                color: Colors.blueGrey,
                padding: EdgeInsets.only(top: 5, left: 15, right: 15, bottom: 5),
                alignment: Alignment.center,
                child: Text(
                  '↓ Ordenar por: Tees | Jugadores | Hcp | MP | ST ↓',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                  textScaleFactor: 1,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        verticalDirection: VerticalDirection.down,
        children: <Widget>[
          Expanded(
            child: dataBody(),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.keyboard_arrow_left,
          size: 40,
        ),
        backgroundColor: Colors.black,
        onPressed: () {
          Navigator.of(context).pop();
          //Navigator.of(context).popUntil((route) => false);
        },
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: 0,
        height: 60.0,
        items: <Widget>[
          Builder(builder: (context) {
            return IconButton(
              icon: Icon(Icons.golf_course, size: 30, color: Colors.white),
            );
          }),
        ],
        color: Color(0xFF1f2f50),
        buttonBackgroundColor: Color(0xFF1f2f50),
        backgroundColor: Colors.transparent,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
      ),
    );
  }

  void _getPostLeaderboard() async {
    _postJuagdoresLeaderboard =
    await Torneo.getLeaderboard(_idTorneo.toString());
    setState(() {});
  }

  void _getTorneo() async {
    _postTorneoLD = await Torneo.getTorneoId(_idTorneo);
    _subTitulo = _postTorneoLD.sub_title;
    setState(() {});
  }

  _localStack() {
    if (_postTorneoLD == null) {
      return stackImage(clubImage: null, clubLogo: null, assetImage: null);
    }
    return stackImage(
        clubImage: _postTorneoLD.postClub.imagen,
        clubLogo: _postTorneoLD.postClub.logo,
        assetImage: 'assets/clubes/logocolor.png');
  }

  Future<void> _llamarResultados(BuildContext context, PostLeaderboard jugador) async {
    if (_flagClickResultado==true ){
      return;
    }
    _flagClickResultado=true;
    List<DataJugadorScore> dtJugSc;
    bool buscoDato=false;
    print(jugador.state_play);
    switch (jugador.state_play) {
      case 'F':
        {
          dtJugSc = await DBApi.getTarjetasScoreFinalxIdTorneo(
              jugador.matricula, int.parse(_postTorneoLD.id_torneo));
          buscoDato=true;
        }
        break;
      case 'C':
        {
          dtJugSc = await DBApi.getTarjetasScoreCondicionalxIdTorneo(
              jugador.matricula, int.parse(_postTorneoLD.id_torneo));
          buscoDato=true;
        }
        break;
      case 'J':
        {
          print(jugador.matricula);
          dtJugSc = await DBApi.getTarjetaScorexIdTorneoTitular(
              jugador.matricula, int.parse(_postTorneoLD.id_torneo));
          if (dtJugSc==null || dtJugSc.length==0) {
            dtJugSc = await DBApi.getTarjetasScorexIdTorneoMatriculaAll(
                jugador.matricula ,int.parse(_postTorneoLD.id_torneo));
          }
          buscoDato=true;
        }
        break;

      default:
        {

        }
    }
    if (dtJugSc==null || dtJugSc.length==0) {
      buscoDato=false;
    }

    if (buscoDato==true) {
      Navigator.push(
        context ,
        PageTransition(
          type: PageTransitionType.fade ,
          child: ResultadosSF(dataSCJugadores: dtJugSc ,
            logo: _postTorneoLD.postClub.logo ,
            image: _postTorneoLD.postClub.imagen ,
            indiceJuga: -1 ,
          ) ,
        ) ,
      );
    }
    _flagClickResultado=false;
  }
}
