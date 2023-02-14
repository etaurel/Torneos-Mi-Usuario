import 'package:connection_status_bar/connection_status_bar.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:golfguidescorecard/herramientas/qr.dart';
import 'package:golfguidescorecard/jugadores/usuariosCrear.dart';
import 'package:golfguidescorecard/models/postTorneo.dart';
import 'package:golfguidescorecard/scoresCard/agregarJugadores.dart';
import 'package:golfguidescorecard/scoresCard/agregarJugadoresPractica.dart';
import 'package:golfguidescorecard/scoresCard/agregarModalidad.dart';
import 'package:golfguidescorecard/scoresCard/leaderBoard.dart';
import 'package:golfguidescorecard/scoresCard/practica.dart';
import 'package:golfguidescorecard/scoresCard/tablaResultados.dart';
import 'package:golfguidescorecard/scoresCard/tablaResultadosSF.dart';
import 'package:golfguidescorecard/scoresCard/torneo.dart';
import 'package:golfguidescorecard/services/db-admin.dart';
import 'package:golfguidescorecard/services/db-api.dart';
import 'package:golfguidescorecard/utilities/Utilities.dart';
import 'package:golfguidescorecard/utilities/display-functions.dart';
import 'package:golfguidescorecard/utilities/fecha.dart';
import 'package:golfguidescorecard/utilities/global-data.dart';
import 'package:golfguidescorecard/utilities/language/lan.dart';
import 'package:golfguidescorecard/utilities/messages-toast.dart';
import 'package:golfguidescorecard/utilities/rc_qr_view.dart';
import 'package:golfguidescorecard/utilities/seguridad.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:page_transition/page_transition.dart';
import 'package:golfguidescorecard/herramientas/myClipper.dart';
import 'package:golfguidescorecard/jugadores/usuariosFT.dart';
import 'package:golfguidescorecard/scoresCard/scoreCard.dart';
import 'package:golfguidescorecard/mod_serv/model.dart';


class Usuarios extends StatefulWidget {
  @override
  _UsuariosState createState() => _UsuariosState();
}

class _UsuariosState extends State<Usuarios> {
  MessagesToast mToast;
  String _messageNoRegistrado= 'No esta registrado. Para registrarse, presione Logout e ingrese nuevamente a la APP.' ;
  TextEditingController controllerCodigoTorneo = new TextEditingController();
  Lan lan = new Lan();
  String matricula;
  PostJuga postJuga;
  PostClub postClub;
  PostUser postUser;
  PostTorneo postTorneo;
  List<PostTorneo> postUserTorneos = [];
  List<DataJugadorScore> _dataJugadoresScoreFinal;
  bool _dialogoTorneosAbierto = false;

  int _idTorneoParaLeaderboad = 0;
  bool _isDisabledButtonJugarTorneo = false;
  bool _isDisabledButtonCrearTorneo = false;
  bool _isDisabledButtonJugarPractica = false;
  bool _isVisibleButtonToScoreCard = true;
  bool _isVisibleButtonToLeaderboards = false;

  bool isLoading = false;
  bool isLoading2 = false;
  bool isLoading3 = false;

  _UsuariosState(
      {Key key,
        @required this.postUser,
        this.postJuga,
        this.postClub,
        this.matricula});

//  @override
//  void initState() {
//    super.initState();
//
//  }
  @override
  Widget build(BuildContext context) {
    _traerTarjetaFinal();
    mToast = MessagesToast(context: context);

    _isDisabledButtonJugarTorneo == false;
    _isDisabledButtonCrearTorneo == false;
    this.postUser = GlobalData.postUser;

    postUserTorneos = GlobalData.postUserTorneos;
    var captionMisTorneos = '';

    if (this.postUserTorneos != null) {
      if (postUserTorneos.length > 0) {
        if (postUserTorneos.length > 1) {
          captionMisTorneos = ' MIS TORNEOS ';
        } else {
          captionMisTorneos = "  ${(postUserTorneos[0].codigo_torneo)}  ";
        }
      }
    }

    print('---------------------  usuarios -------------------------------');

    return  WillPopScope(
      onWillPop: () {
        if(GlobalData.isDrawerOpened) {
          Navigator.pop(context);
          return Future(() => false);
        }
        return Utilities.onWillPop(context);
      },
      child: Scaffold(
        backgroundColor: Color(0xFFE1E1E1),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ClipPath(
                  clipper: MyClipper(),
                  child: Container(
                    height: 300.0,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width - 0,
                          child:
                          Image.network(postUser.images ?? '',
                              fit: BoxFit.fitWidth),
                          color: Colors.black,
                        ),
                        Container(
                          height: 190,
                          width: 150,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              GestureDetector(
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    captionMisTorneos,
                                    textAlign: TextAlign.center,
                                    textScaleFactor: 1.0,
                                    style: TextStyle(
                                      fontSize: 19,
                                      backgroundColor: Colors.redAccent,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  dialogCodigosTorneo(context);
                                },
                              ),
                              Container(
                                padding: EdgeInsets.all(5.0),
                                height: 145,
                                width: 150,
                                color: Colors.white54,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      'Personalizar Foto:',
                                      textScaleFactor: 1.0,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                      ),
                                    ),
                                    GestureDetector(
                                      child: Text(
                                        'foto@scoring.com.ar',
                                        textScaleFactor: 1.0,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.black,
                                        ),
                                      ),
                                      onTap: () {
                                        launch(
                                            "mailto:foto@scoring.com.ar?subject=App%20Golf%20Fotos&body=Subir%20Foto%20y%20agregar%20Nro%20de%20Matricula");
                                      },
                                    ),
                                    Container(
                                      child: SizedBox(
                                        height: 10.0,
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(40.0),
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/clubes/logocolor.png'),
//                                    image: AssetImage('assets/Logo02.png'),
                                            fit: BoxFit.fitHeight),
                                      ),
                                    ),
                                    Container(
                                      child: SizedBox(
                                        height: 7.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            isLoading3
                                ? Center(
                              child: CircularProgressIndicator(
                                backgroundColor: Colors.white,
                              ),
                            )
                                : new
                            Container(
                              width: 60,
                              height: 60,
                              child:
                              RaisedButton(
                                elevation: 5.0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0)),
                                color: Colors.white,
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Image.asset('assets/torneoN.png', scale: 1),
                                    ],
                                  ),
                                ),
                                onPressed: () {
                                  if (postUser.level_security >= (2)) {
                                    if(!_dialogoTorneosAbierto) {
                                      AlertDialogMisTorneosEnJuego(context);
                                    }
                                  } else {
                                    mToast.showToastCancel(_messageNoRegistrado);
                                  }
                                  setState(() {
                                    isLoading3 = true;
                                  });
                                },
                              ),
                            ),
                            Container(
                              height: 10,
                            ),
                          ],
                        ),/// MIS TORNEOS

                        Align(
                          alignment: Alignment.topCenter,
                          child: ConnectionStatusBar(),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  child: SizedBox(
                    height: 10.0,
                  ),
                ),
                Container(
                  color: Colors.black.withOpacity(.6),
                  width: MediaQuery.of(context).size.width - 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          postUser.nombre_juga.toUpperCase() ?? '',
                          textScaleFactor: 1.0,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.white.withOpacity(.6),
                  width: MediaQuery.of(context).size.width - 50,
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Container(
                        child: Text(
                          postUser.matricula ?? '',
                          textScaleFactor: 1.0,
                          textAlign: TextAlign.right,
                          style: TextStyle(fontSize: 25, color: Colors.black),
                        ),
                      ),
                      Container(
                        width: 20,
                        child: Text(
                          "•",
                          textScaleFactor: 1.0,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 25, color: Colors.black),
                        ),
                      ),
                      Container(
                        child: Text(
                          "${postUser.hcp ?? ''}",
                          textScaleFactor: 1.0,
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 30, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: SizedBox(
                    height: 10.0,
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        color: Color(0xFF00FFFF),
                        height: 60,
                        width: MediaQuery.of(context).size.width - 112,
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: TextFormField(
                          maxLength: 5,
                          textCapitalization: TextCapitalization.characters,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          controller: controllerCodigoTorneo,
                          decoration: InputDecoration(
                            counterText: '',
                            hintText: 'CODIGO TORNEO',
                            hintStyle: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                color: Colors.black54),
                          ),
                        ),
                      ),
                      Container(
                        height: 60,
                        width: 60,
                        child: QR(
                          parentAction: _updateMyTitle,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 25,
                  padding: EdgeInsets.only(top: 3, left: 10, right: 10),
                  child: Text(
                    'Ingrese el Código o Escanee el QR',
                    style: TextStyle(fontSize: 18, color: Colors.black54),
                    textAlign: TextAlign.center,
                    textScaleFactor: 1,
                  ),
                ),
                Container(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.all(0),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          RaisedButton(
                            elevation: 5.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100.0)),
                            color: Color(0xFF00FFFF),
                            child: Container(
                              width: 130,
                              height: 162,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Image.asset('assets/play2.png', scale: 0.5),
                                ],
                              ),
                            ),
                            onPressed: () {
                              // actualizaHcpLs();
                              // setState(() {
                              //   postUser.setHcp(GlobalData.postUser.hcp);
                              //   postUser.setLevelSecurity(GlobalData.postUser.level_security);
                              // });
                              if (_isDisabledButtonJugarTorneo == false) {
                                _isDisabledButtonJugarTorneo == true;
                                if (postUser.level_security >= (2)) {
                                  if (controllerCodigoTorneo.text.length == 5) {
                                    // Verificar si existe un torneo
                                    _verificarTorneo(context);
                                  } else {
                                    mToast.showToastCancel('FALTA CODIGO DE TORNEO');
                                    print('FALTA CODIGO DE TORNEO');
                                    _isDisabledButtonJugarTorneo == false;
                                  }
                                }else{

                                  mToast.showToastCancel(_messageNoRegistrado);
                                }
                              } else {
                                print('CONTROL DE RECURRENCIA');
                                //NOTA LUIS : ANALIZAR OTRAS OPCIONES
                              }
                            },
                          ),
                          Container(
                            height: 10,
                          ),
                          Text('JUGAR TORNEO',
                              textScaleFactor: 1.0,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold,
                                  fontSize: 18.0, color: Colors.black)),
//                                color: Colors.white70)),
                        ],
                      ),/// JUGAR TORNEO
                      Container(
                        width: 20,
                      ),
                      Column(
                        children: [
                          Column(
                            children: <Widget>[
                              _raisedButtonCrearTorneo(context),
                              Container(
                                height: 10,
                              ),
                              Text('CREAR TORNEO',
                                  textScaleFactor: 1.0,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 18.0, color: Colors.black)),
//                                color: Colors.white70)),
                            ],
                          ), /// CREAR TORNEO
                          Container(
                            height: 10,
                          ),
                          Column(
                            children: <Widget>[
                              RaisedButton(
                                elevation: 5.0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(70.0)),
                                color: Colors.black,
                                child: Container(
                                  width: 40,
                                  height: 60,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Image.asset('assets/practica.png', scale: 2),
                                    ],
                                  ),
                                ),
                                onPressed: () {
                                  actualizaHcpLs();
                                  setState(() {
                                    postUser.setHcp(GlobalData.postUser.hcp);
                                    postUser.setLevelSecurity(GlobalData.postUser.level_security);
                                  });
                                  if (postUser.level_security >= (2)) {
                                    _verificarPractica(context);
                                  } else {
                                    mToast.showToastCancel(_messageNoRegistrado);
                                  }
//                              Navigator.push(
//                                context,
//                                PageTransition(
//                                  type: PageTransitionType.fade,
//                                  child: UsuariosFT(),
//                                ),
//                              );
                                },
                              ),
                              Container(
                                height: 10,
                              ),
                              Text('PRACTICA',
                                  textScaleFactor: 1.0,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 18.0, color: Colors.black)),
//                                color: Colors.white70)),
                            ],
                          ),/// PRACTICA
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  child: SizedBox(
                    height: 10.0,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        isLoading
                            ? Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Color(0xFFFF0030),
                            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFE1E1E1)),
                          ),
                        )
                            : new RaisedButton(
                          elevation: 5.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0)),
//                color: Color(0xFF1f2f50),
                          color: Color(0xFFFF0030),
                          child: Container(
                            width: 50,
                            height: 60,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image.asset('assets/golfCard2.png', scale: 1),
                              ],
                            ),
                          ),
                          onPressed: () {
                            if (postUser.level_security >= (2)) {
                              _toScoreCard(context);
                            } else {
                              mToast.showToastCancel(_messageNoRegistrado);
                            }

                            setState(() {
                              isLoading = true;
                            });

                          },
                        ),
                        Container(
                          height: 10,
                        ),
                        Text('TARJETA EN JUEGO',
                            textScaleFactor: 1.0,
                            textAlign: TextAlign.center,
                            style:
                            TextStyle(fontSize: 18.0, color: Colors.black)),
                      ],
                    ),/// TARJETA
                    Container(
                      width: 10,
                    ),
                    Column(
                      children: [
                        isLoading2
                            ? Center(
                          child: CircularProgressIndicator(),
                        )
                            : new RaisedButton(
                          elevation: 5.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0)),
                          color: Colors.blue,
//                        color: Color(0xFFFF0030),
                          child: Container(
                            width: 50,
                            height: 60,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image.asset('assets/leaderboard.png', scale: 1),
                              ],
                            ),
                          ),
                          onPressed: () {
                            if (postUser.level_security >= (2)) {
                              if(!_dialogoTorneosAbierto) {
                                AlertDialogTorneosEnJuego(context);
                              }
                            } else {
                              mToast.showToastCancel(_messageNoRegistrado);
                            }

                            setState(() {
                              isLoading2 = true;
                            });

                          },
                        ),
                        Container(
                          height: 10,
                        ),
                        Text('LEADERBOARD',
                            textScaleFactor: 1.0,
                            textAlign: TextAlign.center,
                            style:
                            TextStyle(fontSize: 18.0, color: Colors.black)),
                      ],
                    ),/// LEADERBOARD
                  ],
                ),

/// Botones VIEJOS ######################################
//                 Container(
//                   padding: EdgeInsets.all(0),
//                   alignment: Alignment.center,
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: <Widget>[
//                       Column(
//                         children: <Widget>[
//                           RaisedButton(
//                             elevation: 5.0,
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(70.0)),
//                             color: Color(0xFF00FFFF),
//                             child: Container(
//                               width: 60,
//                               height: 90,
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: <Widget>[
//                                   Image.asset('assets/play2.png', scale: 1),
//                                 ],
//                               ),
//                             ),
//                             onPressed: () {
//                               // actualizaHcpLs();
//                               // setState(() {
//                               //   postUser.setHcp(GlobalData.postUser.hcp);
//                               //   postUser.setLevelSecurity(GlobalData.postUser.level_security);
//                               // });
//                               if (_isDisabledButtonJugarTorneo == false) {
//                                 _isDisabledButtonJugarTorneo == true;
//                                 if (postUser.level_security >= (2)) {
//                                   if (controllerCodigoTorneo.text.length == 5) {
//                                     // Verificar si existe un torneo
//                                     _verificarTorneo(context);
//                                   } else {
//                                     mToast.showToastCancel('FALTA EL CODIGO');
//                                     print('FALTA EL CODIGO');
//                                     _isDisabledButtonJugarTorneo == false;
//                                   }
//                                 }else{
//
//                                   mToast.showToastCancel(_messageNoRegistrado);
//                                 }
//                               } else {
//                                 print('CONTROL DE RECURRENCIA');
//                                 //NOTA LUIS : ANALIZAR OTRAS OPCIONES
//                               }
//                             },
//                           ),
//                           Container(
//                             height: 10,
//                           ),
//                           Text('JUGAR',
//                               textScaleFactor: 1.0,
//                               textAlign: TextAlign.center,
//                               style: TextStyle(
//                                   fontSize: 20.0, color: Colors.black)),
// //                                color: Colors.white70)),
//                         ],
//                       ), /// JUGAR VIEJO
//                       Container(
//                         width: 10,
//                       ),
//                       Column(
//                         children: [
//                           RaisedButton(
//                             elevation: 5.0,
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(70.0)),
//                             color: Color(0xFF1f2f50),
// //                        color: Color(0xFFFF0030),
//                             child: Container(
//                               width: 60,
//                               height: 90,
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: <Widget>[
//                                   Image.asset('assets/leaderboard.png', scale: 1),
//                                 ],
//                               ),
//                             ),
//                             onPressed: () {
//                               launch("https://rgc.golfargentino.com/golf/torneoshabilitadosparareservas.php");
//                             },
//                           ),
//                           Container(
//                             height: 10,
//                           ),
//                           Text('RESERVAS',
//                               textScaleFactor: 1.0,
//                               textAlign: TextAlign.center,
//                               style:
//                               TextStyle(fontSize: 18.0, color: Colors.black)),
//                         ],
//                       ),/// RESERVAS GOLFISTICS
//                       Container(
//                         width: 10,
//                       ),
//                       Column(
//                         children: <Widget>[
//                           RaisedButton(
//                             elevation: 5.0,
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(70.0)),
//                             color: Colors.black,
//                             child: Container(
//                               width: 40,
//                               height: 90,
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: <Widget>[
//                                   Image.asset('assets/practica.png', scale: 1),
//                                 ],
//                               ),
//                             ),
//                             onPressed: () {
//                               actualizaHcpLs();
//                               setState(() {
//                                 postUser.setHcp(GlobalData.postUser.hcp);
//                                 postUser.setLevelSecurity(GlobalData.postUser.level_security);
//                               });
//                               if (postUser.level_security >= (2)) {
//                                 _verificarPractica(context);
//                               } else {
//                                 mToast.showToastCancel(_messageNoRegistrado);
//                               }
// //                              Navigator.push(
// //                                context,
// //                                PageTransition(
// //                                  type: PageTransitionType.fade,
// //                                  child: UsuariosFT(),
// //                                ),
// //                              );
//                             },
//                           ),
//                           Container(
//                             height: 10,
//                           ),
//                           Text('PRACTICA',
//                               textScaleFactor: 1.0,
//                               textAlign: TextAlign.center,
//                               style: TextStyle(
//                                   fontSize: 18.0, color: Colors.black)),
// //                                color: Colors.white70)),
//                         ],
//                       ),/// PRACTICA VIEJA
//                     ],
//                   ),
//                 ),
//                 Container(
//                   child: SizedBox(
//                     height: 10.0,
//                   ),
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Column(
//                       children: [
//                         isLoading
//                             ? Center(
//                           child: CircularProgressIndicator(
//                             backgroundColor: Color(0xFFFF0030),
//                             valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFE1E1E1)),
//                           ),
//                         )
//                             : new RaisedButton(                            elevation: 5.0,
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(50.0)),
// //                color: Color(0xFF1f2f50),
//                           color: Color(0xFFFF0030),
//                           child: Container(
//                             width: 50,
//                             height: 60,
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: <Widget>[
//                                 Image.asset('assets/golfCard2.png', scale: 1),
//                               ],
//                             ),
//                           ),
//                           onPressed: () {
//                             if (postUser.level_security >= (2)) {
//                               _toScoreCard(context);
//                             } else {
//                               mToast.showToastCancel(_messageNoRegistrado);
//                             }
//
//                             setState(() {
//                               isLoading = true;
//                             });
//
//                           },
//                         ),
//                         Container(
//                           height: 10,
//                         ),
//                         Text('TARJETA',
//                             textScaleFactor: 1.0,
//                             textAlign: TextAlign.center,
//                             style:
//                             TextStyle(fontSize: 18.0, color: Colors.black)),
//                       ],
//                     ),/// TARJETA VIEJA
//                     Container(
//                       width: 10,
//                     ),
//                     Column(
//                       children: [
//                         isLoading2
//                             ? Center(
//                           child: CircularProgressIndicator(),
//                         )
//                             : new RaisedButton(
//                           elevation: 5.0,
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(50.0)),
//                           color: Colors.blue,
// //                        color: Color(0xFFFF0030),
//                           child: Container(
//                             width: 50,
//                             height: 60,
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: <Widget>[
//                                 Image.asset('assets/leaderboard.png', scale: 1),
//                               ],
//                             ),
//                           ),
//                           onPressed: () {
//                             if (postUser.level_security >= (2)) {
//                               if(!_dialogoTorneosAbierto) {
//                                 AlertDialogTorneosEnJuego(context);
//                               }
//                             } else {
//                               mToast.showToastCancel(_messageNoRegistrado);
//                             }
//
//                             setState(() {
//                               isLoading2 = true;
//                             });
//
//                           },
//                         ),
//                         Container(
//                           height: 10,
//                         ),
//                         Text('TORNEOS',
//                             textScaleFactor: 1.0,
//                             textAlign: TextAlign.center,
//                             style:
//                             TextStyle(fontSize: 18.0, color: Colors.black)),
//
//                       ],
//                     ),/// LEADERBOARD VIEJO
//                     Container(
//                       width: 10,
//                     ),
//                     Column(
//                       children: [
//                         RaisedButton(
//                           elevation: 5.0,
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(50.0)),
//                           color: Color(0xFF1f2f50),
// //                        color: Color(0xFFFF0030),
//                           child: Container(
//                             width: 50,
//                             height: 60,
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: <Widget>[
//                                 Image.asset('assets/golfCard2.png', scale: 1),
//                               ],
//                             ),
//                           ),
//                           onPressed: () {
//                             launch("https://rgc.golfargentino.com/golf/resultadosporfecha_torneos.php");
//                           },
//                         ),
//                         Container(
//                           height: 10,
//                         ),
//                         Text('SCORES',
//                             textScaleFactor: 1.0,
//                             textAlign: TextAlign.center,
//                             style:
//                             TextStyle(fontSize: 18.0, color: Colors.black)),
//                       ],
//                     ),/// SCORE GOLFISTICS
//
//                   ],
//                 ),
// //                      color: Colors.white70)),
//                 Container(
//                   height: 10,
//                 ),
//                 Column(
//                   children: [
//                     // isLoading
//                     //     ? Center(
//                     //   child: CircularProgressIndicator(),
//                     // )
//                     //     : new
//                     RaisedButton(
//                       elevation: 5.0,
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(50.0)),
//                       color: Colors.indigoAccent,
// //                        color: Color(0xFFFF0030),
//                       child: Container(
//                         width: 50,
//                         height: 60,
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: <Widget>[
//                             Image.asset('assets/leaderboard.png', scale: 1),
//                           ],
//                         ),
//                       ),
//                       onPressed: () {
//                         if (postUser.level_security >= (2)) {
//                           if(!_dialogoTorneosAbierto) {
//                             AlertDialogMisTorneosEnJuego(context);
//                           }
//                         } else {
//                           mToast.showToastCancel(_messageNoRegistrado);
//                         }
//
//                         // setState(() {
//                         //   isLoading = true;
//                         // });
//
//                       },
//                     ),
//                     Container(
//                       height: 10,
//                     ),
//                     Text('MIS LEADERBOARDS',
//                         textScaleFactor: 1.0,
//                         textAlign: TextAlign.center,
//                         style:
//                         TextStyle(fontSize: 18.0, color: Colors.black)),
//                   ],
//                 ),/// LEADERBOARD
                Container(
                  child: SizedBox(
                    height: 50.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _toScoreCard(BuildContext context) async {
    print(Torneo.dataJugadoresScore);
    print(Torneo.postTorneoJuego);
    if (_dataJugadoresScoreFinal != null) {
      PostTorneo _postTorneoLD =
      await Torneo.getTorneoId(_dataJugadoresScoreFinal[0].idTorneo);

      Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.fade,
          child: ResultadosSF(dataSCJugadores: _dataJugadoresScoreFinal,
            logo: _postTorneoLD.postClub.logo,
            image: _postTorneoLD.postClub.imagen,
            indiceJuga: -1,
          ),
        ),
      );
    } else {
      if (Torneo.dataJugadoresScore == null || Torneo.postTorneoJuego == null) {
        mToast.showToast('NO HAY TARJETA EN JUEGO');
        print('NO HAY TARJETA EN JUEGO');
      } else {
        var haySinTee = 0;
        var quienesSinTee = '';
        Torneo.dataJugadoresScore.forEach((juga) {
          //print(juga.pathTeeColor);
          if (juga.pathTeeColor == null || juga.pathTeeColor.length <= 5) {
            haySinTee++;
            quienesSinTee = quienesSinTee + juga.nombre_juga + ', ';
          }
        });
        // if (haySinTee > 0) {
        if (haySinTee > -1) {
          //NOTA falataria un alert u otra cosa
          print('FALTA SELECCIONAR TEE DE: ' + quienesSinTee);
          postTorneo = Torneo.postTorneoJuego;
          Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.fade,
              // child: AgregaJuga(
              child: AgregaModalidad(
                postTorneo: postTorneo,
              ),
            ),
          );
        } else {
          Navigator.push(
              context,
              PageTransition(type: PageTransitionType.fade, child: ScoreCard()
                // TODO The getter 'postClub' was called on null. Receiver: null Tried calling: postClub (ERROR LOGOUT pantalla Roja)
              ));
        }
      }
    }

    setState(() {
      isLoading = false;
    });

  }

  Future<void> _traerTarjetaFinal() async {
//    List<DataJugadorScore> _dataJugadoresScoreFinal  = await DBApi.getTarjetasScoreFinal(GlobalData.postUser.idjuga_arg, Fecha.fechaHoy);
    if (GlobalData.postUser != null) {
      _dataJugadoresScoreFinal = await DBApi.getTarjetasScoreFinalxFecha(
          GlobalData.postUser.idjuga_arg, Fecha.fechaHoy);
    }
  }

  _raisedButtonCrearTorneo(context) {
    return RaisedButton(
      elevation: 5.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
      color: Colors.lightBlueAccent,
      child: Container(
        width: 40,
        height: 60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/torneoN.png', scale: 1.7),
          ],
        ),
      ),
      onPressed: () {
        if (_isDisabledButtonCrearTorneo == false) {
          if (postUser.level_security >= (2)) {
            if (postUserTorneos == null) {
              postUserTorneos = [];
            }
            if (postUserTorneos.length == 0 || postUser.level_security > 2) {
              _isDisabledButtonCrearTorneo == true;
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.fade,
                  child:
                  UsuariosCrear(), //TODO error The getter 'images' was called on null. Receiver: null Tried calling: images (ERROR LOGOUT pantalla Roja)
                ),
              );
            } else {
              print('SOLO PUEDE CREAR UN TORNEO DIARIO ');
              _isDisabledButtonCrearTorneo == false;
            }
          } else {

            mToast.showToastCancel(_messageNoRegistrado);

            /// llamar alerta de Registro y enviar a Formulario registro
            print(
                '--------------------------  AQUI ALERTA! -------------------------------');

            // TODO Preguntar si quiere retgistarse, probocar un logout y navegar al Login

            //return dialogUserUpdate(context); // createAlertDialogReg(context);
          }
        } else {}
      },
    );
  }

  dialogCodigosTorneo(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            content: Container(
              decoration:
              BoxDecoration(borderRadius: BorderRadius.circular(16)),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      color: Colors.black,
                      alignment: Alignment.center,
                      child: Text(
                        'MIS CODIGOS DE TORNEOS',
                        textScaleFactor: 1,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: DataTable(
                        columnSpacing: 0,
                        horizontalMargin: 10,
                        headingRowHeight: 10,
                        dataRowHeight: 170,
                        columns: [
                          DataColumn(
                            label: Text(''),
                          ),
                          DataColumn(
                            label: Text(''),
                          ),
                        ],
                        rows: postUserTorneos
                            .map(
                              (codigo_lista) => DataRow(cells: [
                            DataCell(
                              Container(
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      codigo_lista.codigo_torneo,
                                      textAlign: TextAlign.center,
                                      textScaleFactor: 1,
                                      style: TextStyle(
                                        fontSize: 40,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.redAccent,
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      child: Column(
                                        children: <Widget>[
                                          Text(
                                            "${(codigo_lista.title)}",
                                            textScaleFactor: 1,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w800,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Text(
                                            "${(codigo_lista.sub_title)}",
                                            textScaleFactor: 1,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w800,
                                              color: Colors.redAccent,
                                            ),
                                          ),
                                          Text(
                                            Fecha.stringDateToStringLocalLarge(codigo_lista.start_date),
                                            textScaleFactor: 1,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Text(
                                            "${(codigo_lista.modalidad)}",
                                            textScaleFactor: 1,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w800,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () {
                                controllerCodigoTorneo.text =
                                    codigo_lista.codigo_torneo;
                                Navigator.of(context).pop();
                              },

                            ),
                            DataCell(
                              Container(
                                alignment: Alignment.centerRight,
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: <Widget>[
                                    GestureDetector(
                                      child: Container(
                                        height: 45,
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.only(
                                            left: 15, top: 4, bottom: 4),
                                        child: Text(
                                          'QR',
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.center,
                                          textScaleFactor: 1,
                                        ),
                                      ),
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          PageTransition(
                                            type: PageTransitionType.fade,
                                            child: RcQrView(postTorneoCod: codigo_lista ),
                                          ),
                                        );
                                      },
                                    ),
                                    IconButton(
                                      padding: EdgeInsets.only(
                                          left: 15, top: 4, bottom: 4),
                                      icon: Icon(Icons.system_update_alt,
                                          size: 28),
                                      onPressed: () {
                                        Share.text(
                                            'CODIGO ',
                                            codigo_lista.codigo_torneo,
                                            'text/plain');
                                      },
                                    ),
                                    IconButton(
                                      padding: EdgeInsets.only(
                                          left: 15, top: 4, bottom: 4),
                                      icon: Icon(Icons.delete, size: 28),
                                      onPressed: () {
                                        _deleteTorneo(codigo_lista);
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ]),
                        )
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  void AlertDialogMisTorneosEnJuego(BuildContext context) async {
    // postUserTorneos =
    // await Torneo.getTorneosMios(postUser.matricula);
    // GlobalData.postUserTorneos = postUserTorneos;
    //
    // postUserTorneos.sort((a, b) => b.start_date.compareTo(a.start_date)); /// Ordena por fecha descendente
    //
    // var torneosJugados = postUserTorneos.where((torneo) => torneo.id_user == postUser.matricula).toList();

    _dialogoTorneosAbierto = true;
    /// BUSCAR TODOS LOS TORNEOS
    List<PostTorneo> postTorneosEnJuego = await Torneo.getTorneosMios(postUser.matricula);

    postTorneosEnJuego.sort((a, b) => b.start_date.compareTo(a.start_date)); /// Ordena por fecha descendente

    var torneosJugados = postTorneosEnJuego.where((torneo) => torneo.id_user == postUser.matricula).toList();

    bool retornoDialogo = await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            content: Container(
              decoration:
              BoxDecoration(borderRadius: BorderRadius.circular(16)),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      color: Colors.black,
                      alignment: Alignment.center,
                      child: Text(
                        'MIS TORNEOS CREADOS',
                        textScaleFactor: 1,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: DataTable(
                        columnSpacing: 0,
                        horizontalMargin: 5,
                        headingRowHeight: 5,
                        dataRowHeight: 90,
                        columns: [
                          DataColumn(
                            label: Text(''),
                          ),
                        ],
                        rows: torneosJugados
                            .map(
                              (torneoFecha) => DataRow(cells: [
                            DataCell(
                              Container(
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      torneoFecha.title,
                                      textAlign: TextAlign.center,
                                      textScaleFactor: 1,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      torneoFecha.sub_title,
                                      textScaleFactor: 1,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.redAccent,
                                      ),
                                    ),
                                    Text(
                                      Fecha.stringDateToStringLocalLarge(torneoFecha.start_date),
                                      // "${(torneoFecha.modalidad)}",
                                      textScaleFactor: 1,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () {
                                _idTorneoParaLeaderboad = int.parse(
                                    torneoFecha.id_torneo);
                                _dialogoTorneosAbierto = false;
                                Navigator.pushReplacement(
                                  context,
                                  PageTransition(
                                    ctx: context,
                                    type: PageTransitionType.fade,
                                    child: Leaderboard(
                                        idTorneo:
                                        _idTorneoParaLeaderboad),
                                  ),
                                );
                              },
                            ),
                          ]),
                        )
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });

    if(retornoDialogo == null) {
      _dialogoTorneosAbierto = false;
    }

    setState(() {
      isLoading3 = false;
    });


    // return retornoDialogo;
  }

/// AlertDialogTorneosEnJuego
  AlertDialogTorneosEnJuego(BuildContext context) async {
    _dialogoTorneosAbierto = true;
    /// BUSCAR TODOS LOS TORNEOS
    List<PostTorneo> postTorneosEnJuego = await Torneo.getTorneosFecha(Fecha.fechaHoy);

    bool retornoDialogo = await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            content: Container(
              decoration:
              BoxDecoration(borderRadius: BorderRadius.circular(16)),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      color: Colors.black,
                      alignment: Alignment.center,
                      child: Text(
                        'TORNEOS EN JUEGO',
                        textScaleFactor: 1,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: DataTable(
                        columnSpacing: 0,
                        horizontalMargin: 5,
                        headingRowHeight: 5,
                        dataRowHeight: 90,
                        columns: [
                          DataColumn(
                            label: Text(''),
                          ),
                        ],
                        rows: postTorneosEnJuego
                            .map(
                              (torneoFecha) => DataRow(cells: [
                            DataCell(
                              Container(
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      torneoFecha.title,
                                      textAlign: TextAlign.center,
                                      textScaleFactor: 1,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      "${(torneoFecha.sub_title)}",
                                      textScaleFactor: 1,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.redAccent,
                                      ),
                                    ),
                                    Text(
                                      "${(torneoFecha.modalidad)}",
                                      textScaleFactor: 1,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () {
                                _idTorneoParaLeaderboad = int.parse(
                                    torneoFecha.id_torneo);
                                _dialogoTorneosAbierto = false;
                                Navigator.pushReplacement(
                                  context,
                                  PageTransition(
                                    ctx: context,
                                    type: PageTransitionType.fade,
                                    child: Leaderboard(
                                        idTorneo:
                                        _idTorneoParaLeaderboad),
                                  ),
                                );
                              },
                            ),
                          ]),
                        )
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });

    if(retornoDialogo == null) {
      _dialogoTorneosAbierto = false;
    }

    setState(() {
      isLoading2 = false;
    });


    return retornoDialogo;
  }

  _deleteTorneo(PostTorneo codigo_torneo) {
    if (codigo_torneo.codigo_torneo == postUser.matricula) {
      // NOTA: ¿se avisa?
      print('NO BORRA LA LICENCIA DEL USER');
    } else {
//      _showProgress('Deleting Jugador...');
      postUserTorneos.remove(codigo_torneo);
      Torneo.postUserTorneos = postUserTorneos;
    }
  }

  void _verificarTorneo(BuildContext context) async {
//    print(Torneo.postTorneoJuego.codigo_torneo??'null');
//    print(controllerCodigoTorneo.text);

    if (_dataJugadoresScoreFinal == null) {
      _dataJugadoresScoreFinal = await DBApi.getTarjetasScoreFinalxFecha(
          GlobalData.postUser.idjuga_arg, Fecha.fechaHoy);
    }

    if (Torneo.dataJugadoresScore != null && Torneo.postTorneoJuego != null) {
      if (Torneo.postTorneoJuego.codigo_torneo.toUpperCase() !=
          controllerCodigoTorneo.text.toUpperCase()) {
        print(
            'Hay inicializada una tarjetas, esta acción elimina dichas tarjetas');
        //var _pasaDato;
        var _pasaDato = await dialogoOkCancel(
            context: context,
            title: lan.dialogTarjetaJuegoInicializadaTitulo,
            question: lan.dialogTarjetaJuegoInicializadaQuestion);
        if (_pasaDato == false) {
          return;
        }
        Torneo.dataJugadoresScore = null;
        Torneo.postTorneoJuego = null;
      }
    }

    if (await Torneo.getTorneo(controllerCodigoTorneo.text) == true) {
      if (Fecha.fechaDiferencia(
          DateTime.parse(Torneo.postTorneoJuego.start_date),
          Fecha.fechaHoy) !=
          0) {
        //NOTA : ver si se muestra...
        print('EL TORNEO, NO es del Día');
        mToast.showToastCancel('EL TORNEO, NO es del Día');
      } else {
        //mToast.showToastCancel('PROVISORIO CONTROL DE TARJETA FINAL');

        if (_dataJugadoresScoreFinal != null) {

          print(_dataJugadoresScoreFinal[0].idTorneo);
          print(Torneo.postTorneoJuego.id_torneo);

          if (_dataJugadoresScoreFinal[0].idTorneo==int.parse(Torneo.postTorneoJuego.id_torneo)) {
            print(
                '*** NOTIFICACIÓN *** YA TIENE CERRADA UNA TARJETA EL DIA DE HOY');
            mToast.showToastCancel('YA TIENE CERRADA UNA TARJETA EL DIA DE HOY');
            return;
          }else{
            print(
                '*** NOTIFICACIÓN *** YA TIENE CERRADA UNA TARJETA pero pasa');
          }
        }
        postTorneo = Torneo.postTorneoJuego;
        DBAdmin.dbTorneoInsert(postTorneo);
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.fade,
            // child: AgregaJuga(
            child: AgregaModalidad(
              postTorneo: postTorneo,
            ),
          ),
        );
      }
    } else {
      // NOTA: Avisar que no existe el codigo
      print('NO EXISTE EL TORNEO');
      mToast.showToastCancel('NO EXISTE EL TORNEO');
    }
  }

  void _verificarPractica(BuildContext context) async {
    if (Practica.practicaJugadoresScore != null &&
        Practica.postPracticaJuego != null) {
      print(
          'Hay inicializada una tarjeta de Práctica, esta acción elimina dicha tarjeta');
      //var _pasaDato;
      var _pasaDato = await dialogoOkCancel(
          context: context,
          title: 'HAY UNA TARJETA DE PRACTICA ACTIVA',
          question: '¿Continua con la misma tarjeta?');
      if (_pasaDato == true) {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.fade,
            child: AgregaJugaPract(
              postPractica: Practica.postPracticaJuego,
            ),
          ),
        );
      } else {
        Practica.practicaJugadoresScore = null;
        Practica.postPracticaJuego = null;
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.fade,
            child: UsuariosFT(),
          ),
        );
      }
    } else {
      Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.fade,
          child: UsuariosFT(),
        ),
      );
    }
  }


  _updateMyTitle(String text) {
//    setState(() {
//      myTitle = text;
//    });
    controllerCodigoTorneo.text = text;
  }


}
