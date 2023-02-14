import 'dart:convert';
import 'dart:typed_data';

import 'package:golfguidescorecard/mod_serv/model.dart';
import 'package:golfguidescorecard/scoresCard/torneo.dart';
import 'package:golfguidescorecard/services/db-admin.dart';
import 'package:golfguidescorecard/utilities/global-data.dart';
import 'package:golfguidescorecard/utilities/user-funtions.dart';
import 'package:flutter/foundation.dart';


class DataHoyoJuego {
  int _hoyoNro;

  int get hoyoNro => _hoyoNro;

  int _distancia = 0;
  int get distancia => _distancia;
  set distancia(int distancia) {
    _distancia = distancia;
  }

  int _par = 0;
  int get par => _par;
  set par(int par) {
    _par = par;
  }

  int _handicap = 0;
  int get handicap => _handicap;
  set handicap(int handicap) {
    _handicap = handicap;
  }

  int _golpesHcp = 0;
  int get golpesHcp => _golpesHcp;
  set golpesHcp(int golpes) {
    _golpesHcp = golpes;
  }

  int _golpesHcpStb = 0;
  int get golpesHcpStb => _golpesHcpStb;
  set golpesHcpStb(int golpes) {
    _golpesHcpStb = golpes;
  }


  int _stableford = 0;

  int get stableford => _stableford;

  set stableford(int stableford) {
    _stableford = stableford;
  }

  int _score = 0;
  int get score => _score;
  set score(int score) {
    _score = score;
    if (score == 0) {
      _neto = 0;
      _scoreState = 0;
      _scoreCtrol = 0;
      _stableford = 0;
    } else {
      _neto = (score - _golpesHcp) - par;
      var netoStableford= (score - _golpesHcpStb) - par;
      print("_golpesHcpStb--------set score--------------------------");
      print(_golpesHcpStb);


      _stableford = UserFunctions.resolverStableford(netoStableford);
      if (score > 0) {
        if (_scoreCtrol == 0) {
          _scoreState = 0;
        } else {
          if (_scoreCtrol == score) {
            _scoreState = 2;
          } else {
            _scoreState = 1;
          }
        }
      }
    }
//    print('hoyo');
//    print(_golpesHcp);
//    print( handicap);
//    print('---');
//    print(_neto);
//    print(_score);
  }

  int _scoreState = 0;
  int get scoreState => _scoreState;
  set scoreState(int scoreState) {
    _scoreState = scoreState;
  }

  int _scoreCtrol = 0;
  int get scoreCtrol => _scoreCtrol;

  set scoreCtrol(int scoreCtrol) {
    _scoreCtrol = scoreCtrol;
  }

  int _neto = 0;
  int get neto => _neto;

  DataHoyoJuego(int hoyoNro, int distancia, int par, int handicap,
      int golpesHcp, int score, int scoreCtrol, int neto, int golpesHcpStb) {
    _hoyoNro = hoyoNro;
    _distancia = distancia;
    _par = par;
    _handicap = handicap;
    _golpesHcp = golpesHcp;
    _score = score;
    _scoreCtrol = scoreCtrol;
    _neto = neto;
    _golpesHcpStb= golpesHcpStb;
  }
}

/// **************************************************************************************
///  DataJugadorScore
/// **************************************************************************************
///

class DataJugadorScore {
  String status_med = '';
  String status_sta = '';
  String status_mch = '';

  int _role = 0;
  int get role => _role;
  set role(int role) {
    _role = role;
  }

  Uint8List _firmaUserImage = new Uint8List(0);
  Uint8List get firmaUserImage => _firmaUserImage;
  set firmaUserImage(Uint8List firmaUserImage) {
    _firmaUserImage = firmaUserImage;
  }

  String _firmaMarcadorMatricula = '';
  String get firmaMarcadorMatricula => _firmaMarcadorMatricula;
  set firmaMarcadorMatricula(String firmaMarcadorMatricula) {
    _firmaMarcadorMatricula = firmaMarcadorMatricula;
  }

  Uint8List _firmaMarcadorImage = new Uint8List(0);
  Uint8List get firmaMarcadorImage => _firmaMarcadorImage;
  set firmaMarcadorImage(Uint8List firmaMarcadorImage) {
    _firmaMarcadorImage = firmaMarcadorImage;
  }

  int _idClubCanchaTee = 0;

  int get idClubCanchaTee => _idClubCanchaTee;

  set idClubCanchaTee(int idClubCanchaTee) {
    _idClubCanchaTee = idClubCanchaTee;
  }

  int _idTorneo = 0;

  int get idTorneo => _idTorneo;

  set idTorneo(int idTorneo) {
    _idTorneo = idTorneo;
  }

  String _nombre_juga = '';

  String get nombre_juga => _nombre_juga;

  set nombre_juga(String nombre_juga) {
    _nombre_juga = nombre_juga;
  }

  String _images = '';

  String get images => _images;

  set images(String images) {
    _images = images;
  }

  String _pathTeeColor = '';

  String get pathTeeColor => _pathTeeColor;

  set pathTeeColor(String pathTeeColor) {
    _pathTeeColor = pathTeeColor;
  }

  String _sexo;

  String get sexo => _sexo;

  set sexo(String sexo) {
    _sexo = sexo;
  }

  String _matricula = '';
  String get matricula => _matricula;
  set matricula(String matricula) {
    _matricula = matricula;
  }

  double _hcpIndex = 0;
  double get hcpIndex => _hcpIndex;
  set hcpIndex(double hcpIndex) {
    _hcpIndex = hcpIndex;
  }

  double _hcp3 = 0;

  double get hcp3 => _hcp3;

  set hcp3(double hcp3) {
    _hcp3 = hcp3;
  }

  int _hcpTorneo = 0;
  int get hcpTorneo => _hcpTorneo;
  set hcpTorneo(int hcpTorneo) {
    _hcpTorneo = hcpTorneo;
  }

  int _ida = 0;
  int _vuelta = 0;
  int _gross = 0;
  int _neto = 0;
  int _netoAlPar = 0;

  int _stableford = 0;

  int get stableford => _stableford;

  set stableford(int stableford) {
    _stableford = stableford;
  }

  int _stablefordIda = 0;
  int get stablefordIda => _stablefordIda;

  set stablefordIda(int stablefordIda) {
    _stablefordIda = stablefordIda;
  }

  int _stablefordVuelta = 0;

  int get stablefordVuelta => _stablefordVuelta;

  set stablefordVuelta(int stablefordVuelta) {
    _stablefordVuelta = stablefordVuelta;
  }

  int get ida => _ida;
  set ida(int ida) {
    _ida = ida;
  }

  int get vuelta => _vuelta;
  set vuelta(int vuelta) {
    _vuelta = vuelta;
  }

  int get gross => _gross;
  set gross(int gross) {
    _gross = gross;
  }

  int get neto => _neto;
  set neto(int neto) {
    _neto = neto;
  }

  int get netoAlPar => _netoAlPar;
  set netoAlPar(int netoAlPar) {
    _netoAlPar = netoAlPar;
  }

  PostTee _postTee;

  PostTee get postTee => _postTee;
  set postTee(PostTee postTee) {
    _postTee = postTee;
  }

  //List<DataHoyoJuego> hoyos = new List(18);
  List<DataHoyoJuego> hoyos = new List(0);

  DataJugadorScore(
      {int idTorneo,
      int idClubCanchaTee,
      String matricula,
      double hcpIndex,
      double hcp3,
      int hcpTorneo,
      String nombre_juga,
      String images,
      String pathTeeColor,
      String sexo,
      int role}) {
    _idTorneo = idTorneo;
    _idClubCanchaTee = idClubCanchaTee;
    _matricula = matricula;
    _hcpIndex = hcpIndex;
    _hcp3 = hcp3;
    _hcpTorneo = hcpTorneo;
    _nombre_juga = nombre_juga;
    _images = images;
    _pathTeeColor = pathTeeColor;
    _sexo = sexo;
    _role = role;
  }
  DataJugadorScore.origen(
      {int idTorneo,
      int idClubCanchaTee,
      String matricula,
      double hcpIndex,
      double hcp3,
      int hcpTorneo,
      String nombre_juga,
      String images,
      String pathTeeColor,
      String sexo,
      int ida,
      int vuelta,
      int gross,
      neto,
      int netoAlPar,
      int stableford,
      int stablefordIda,
      int stablefordVuelta,
      Uint8List firmaUserImage,
      String firmaMarcadorMatricula,
      Uint8List firmaMarcadorImage,
      int role,
        String status_med,
        String status_sta,
        String status_mch}) {
    _idTorneo = idTorneo;
    _idClubCanchaTee = idClubCanchaTee;
    _matricula = matricula;
    _hcpIndex = hcpIndex;
    _hcp3 = hcp3;
    _hcpTorneo = hcpTorneo;
    _nombre_juga = nombre_juga;
    _images = images;
    _pathTeeColor = pathTeeColor;
    _sexo = sexo;
    _ida = ida;
    _vuelta = vuelta;
    _gross = gross;
    _neto = neto;
    _netoAlPar = netoAlPar;
    _stableford = stableford;
    _stablefordIda = stablefordIda;
    _stablefordVuelta = stablefordVuelta;
    _firmaUserImage = firmaUserImage;
    _firmaMarcadorMatricula = firmaMarcadorMatricula;
    _firmaMarcadorImage = firmaMarcadorImage;
    _role = role;
    this.status_med = status_med;
    this.status_sta = status_sta;
    this.status_mch = status_mch;
  }

  factory DataJugadorScore.fromJson2(Map<String, dynamic> json) {
    return DataJugadorScore.origen(
      firmaMarcadorMatricula: json['firma_marcador_matricula'].toString(),
      firmaMarcadorImage:
          UserFunctions.toUintImage(json['firma_marcador_image'] ?? ''),
      firmaUserImage: UserFunctions.toUintImage(json['firma_user_image'] ?? ''),
      idTorneo: int.parse(json['id_torneo'].toString()),
      idClubCanchaTee: int.parse(json['id_club_cancha_tee'].toString()),
      matricula: json['matricula'] as String,
      hcpIndex: double.parse(json['hcp_index'].toString()),
      hcp3: double.parse(json['hcp_index'].toString()),
      hcpTorneo: int.parse(json['hcp_torneo']),
      nombre_juga: json['nombre_juga'] as String,
      images: json['images'] as String,
      pathTeeColor: json['path_tee_color'] as String,
      sexo: json['sexo'] as String,
      ida: int.parse(json['ida'].toString()),
      vuelta: int.parse(json['vuelta'].toString()),
      gross: int.parse(json['gross'].toString()),
      neto: int.parse(json['neto'].toString()),
      netoAlPar: int.parse(json['neto_al_par'].toString()),
      stableford: int.parse(json['stableford'].toString()),
      stablefordIda: int.parse(json['stableford_ida'].toString()),
      stablefordVuelta: int.parse(json['stableford_vuelta'].toString()),
      role: int.parse(json['role'].toString()),
      status_med:json['status_med'] as String,
      status_sta: json['status_sta'] as String,
      status_mch:json['status_mch'] as String
    );
  }

  addHoyo(int hoyoNro, int distancia, int par, int handicap) {
    //=(INT(hcpJugador/18)+if(MOD(hcpJugador,18)>=hcpDelHoyo,1,0))
    int golpesHcp = 0;
    if (_hcpTorneo < 0) {
      golpesHcp = (_hcpTorneo ~/ 18) +
          UserFunctions.miif((_hcpTorneo % 18) < handicap, -1, 0);
    } else {
      golpesHcp = (_hcpTorneo ~/ 18) +
          UserFunctions.miif((_hcpTorneo % 18) >= handicap, 1, 0);
    }
  /// STABLEFORD ----------------------------------------------
    int golpesHcpStb = 0;
    int hcpStbTorneo=(hcpTorneo*0.85).round();
    print("hcpStbTorneo---------------------");
    print(hcpStbTorneo);
    // int hcpStbTorneo=(hcpTorneo*1).round();
    if (hcpStbTorneo < 0) {
      golpesHcpStb = (hcpStbTorneo ~/ 18) +
          UserFunctions.miif((hcpStbTorneo % 18) < handicap, -1, 0);
    } else {
      golpesHcpStb = (hcpStbTorneo ~/ 18) +
          UserFunctions.miif((hcpStbTorneo % 18) >= handicap, 1, 0);
    }


    hoyos[hoyoNro - 1] = new DataHoyoJuego(
        hoyoNro, distancia, par, handicap, golpesHcp, 0, 0, 0,golpesHcpStb);
  }

  addHoyos(DataJugadorScore jugador) {
    hoyos = new List(18);
    jugador.addHoyo(1, int.parse(jugador.postTee.d1),
        int.parse(jugador.postTee.p1), int.parse(jugador.postTee.h1));
    jugador.addHoyo(2, int.parse(jugador.postTee.d2),
        int.parse(jugador.postTee.p2), int.parse(jugador.postTee.h2));
    jugador.addHoyo(3, int.parse(jugador.postTee.d3),
        int.parse(jugador.postTee.p3), int.parse(jugador.postTee.h3));
    jugador.addHoyo(4, int.parse(jugador.postTee.d4),
        int.parse(jugador.postTee.p4), int.parse(jugador.postTee.h4));
    jugador.addHoyo(5, int.parse(jugador.postTee.d5),
        int.parse(jugador.postTee.p5), int.parse(jugador.postTee.h5));
    jugador.addHoyo(6, int.parse(jugador.postTee.d6),
        int.parse(jugador.postTee.p6), int.parse(jugador.postTee.h6));
    jugador.addHoyo(7, int.parse(jugador.postTee.d7),
        int.parse(jugador.postTee.p7), int.parse(jugador.postTee.h7));
    jugador.addHoyo(8, int.parse(jugador.postTee.d8),
        int.parse(jugador.postTee.p8), int.parse(jugador.postTee.h8));
    jugador.addHoyo(9, int.parse(jugador.postTee.d9),
        int.parse(jugador.postTee.p9), int.parse(jugador.postTee.h9));
    jugador.addHoyo(10, int.parse(jugador.postTee.d10),
        int.parse(jugador.postTee.p10), int.parse(jugador.postTee.h10));
    jugador.addHoyo(11, int.parse(jugador.postTee.d11),
        int.parse(jugador.postTee.p11), int.parse(jugador.postTee.h11));
    jugador.addHoyo(12, int.parse(jugador.postTee.d12),
        int.parse(jugador.postTee.p12), int.parse(jugador.postTee.h12));
    jugador.addHoyo(13, int.parse(jugador.postTee.d13),
        int.parse(jugador.postTee.p13), int.parse(jugador.postTee.h13));
    jugador.addHoyo(14, int.parse(jugador.postTee.d14),
        int.parse(jugador.postTee.p14), int.parse(jugador.postTee.h14));
    jugador.addHoyo(15, int.parse(jugador.postTee.d15),
        int.parse(jugador.postTee.p15), int.parse(jugador.postTee.h15));
    jugador.addHoyo(16, int.parse(jugador.postTee.d16),
        int.parse(jugador.postTee.p16), int.parse(jugador.postTee.h16));
    jugador.addHoyo(17, int.parse(jugador.postTee.d17),
        int.parse(jugador.postTee.p17), int.parse(jugador.postTee.h17));
    jugador.addHoyo(18, int.parse(jugador.postTee.d18),
        int.parse(jugador.postTee.p18), int.parse(jugador.postTee.h18));
  }

  getScore(int hoyoNro) {
    return hoyos[hoyoNro - 1].score;
  }

  setScoreControl(int hoyoNro, int scoreCtrol) {
    hoyos[hoyoNro - 1].scoreCtrol = scoreCtrol;
    if (hoyos[hoyoNro - 1].score == 0 && scoreCtrol > 0) {
      hoyos[hoyoNro - 1].scoreState = 1;
    } else if (hoyos[hoyoNro - 1].score > 0 && scoreCtrol == 0) {
      hoyos[hoyoNro - 1].scoreState = 1;
    } else {
      if (hoyos[hoyoNro - 1].score == scoreCtrol) {
        hoyos[hoyoNro - 1].scoreState = 0;
      } else {
        hoyos[hoyoNro - 1].scoreState = 2;
      }
    }
  }

  setScoreNotDB(int hoyoNro, int score) {
    hoyos[hoyoNro - 1].score = score;

    _gross = 0;
    _neto = 0;
    _netoAlPar = 0;
    _ida = 0;
    _vuelta = 0;
    _stableford = 0;
    _stablefordIda = 0;
    _stablefordVuelta = 0;
    hoyos.forEach((hoyo) {
      if (hoyo._hoyoNro <= 9) {
        _ida = _ida + hoyo.score;
        _stablefordIda = _stablefordIda + hoyo.stableford;
      } else {
        _vuelta = _vuelta + hoyo.score;
        _stablefordVuelta = _stablefordVuelta + hoyo.stableford;
      }
      _netoAlPar = _netoAlPar + hoyo.neto;
      _stableford = _stableford + hoyo.stableford;
    });
    _gross = _ida + _vuelta;
    _neto = _gross - _hcpTorneo;
  }

  setScore(int hoyoNro, int score) {
    this.setScoreNotDB(hoyoNro, score);

    ///Grabar SQLITE y API PHP-MYSQL

    DBAdmin.TarjetaUpdateScore(
        Torneo.postTorneoJuego.id_torneo,
        GlobalData.postUser.idjuga_arg,
        this._matricula,
        hoyoNro,
        hoyos[hoyoNro - 1].score,
        hoyos[hoyoNro - 1].scoreState,
        hoyos[hoyoNro - 1].scoreCtrol,
        hoyos[hoyoNro - 1].neto,
        hoyos[hoyoNro - 1].stableford);
  }
}

class PostTee {
  final String id_club_cancha_tee;
  final String id_club_cancha;
  final String start;
  final String tee;
  final String category;
  final String ida_9h_course_rating;
  final String ida_9h_slope;
  final String vta_9h_course_rating;
  final String vta_9h_slope;
  final String course_rating;
  final String slope;
  final String yards;
  final String par;
  final String p1;
  final String p2;
  final String p3;
  final String p4;
  final String p5;
  final String p6;
  final String p7;
  final String p8;
  final String p9;
  final String p10;
  final String p11;
  final String p12;
  final String p13;
  final String p14;
  final String p15;
  final String p16;
  final String p17;
  final String p18;
  final String d1;
  final String d2;
  final String d3;
  final String d4;
  final String d5;
  final String d6;
  final String d7;
  final String d8;
  final String d9;
  final String d10;
  final String d11;
  final String d12;
  final String d13;
  final String d14;
  final String d15;
  final String d16;
  final String d17;
  final String d18;
  final String h1;
  final String h2;
  final String h3;
  final String h4;
  final String h5;
  final String h6;
  final String h7;
  final String h8;
  final String h9;
  final String h10;
  final String h11;
  final String h12;
  final String h13;
  final String h14;
  final String h15;
  final String h16;
  final String h17;
  final String h18;

  PostTee({
    @required this.id_club_cancha_tee,
    @required this.id_club_cancha,
    @required this.start,
    @required this.tee,
    @required this.category,
    @required this.ida_9h_course_rating,
    @required this.ida_9h_slope,
    @required this.vta_9h_course_rating,
    @required this.vta_9h_slope,
    @required this.course_rating,
    @required this.slope,
    @required this.yards,
    @required this.par,
    @required this.p1,
    @required this.p2,
    @required this.p3,
    @required this.p4,
    @required this.p5,
    @required this.p6,
    @required this.p7,
    @required this.p8,
    @required this.p9,
    @required this.p10,
    @required this.p11,
    @required this.p12,
    @required this.p13,
    @required this.p14,
    @required this.p15,
    @required this.p16,
    @required this.p17,
    @required this.p18,
    @required this.d1,
    @required this.d2,
    @required this.d3,
    @required this.d4,
    @required this.d5,
    @required this.d6,
    @required this.d7,
    @required this.d8,
    @required this.d9,
    @required this.d10,
    @required this.d11,
    @required this.d12,
    @required this.d13,
    @required this.d14,
    @required this.d15,
    @required this.d16,
    @required this.d17,
    @required this.d18,
    @required this.h1,
    @required this.h2,
    @required this.h3,
    @required this.h4,
    @required this.h5,
    @required this.h6,
    @required this.h7,
    @required this.h8,
    @required this.h9,
    @required this.h10,
    @required this.h11,
    @required this.h12,
    @required this.h13,
    @required this.h14,
    @required this.h15,
    @required this.h16,
    @required this.h17,
    @required this.h18,
  });

  factory PostTee.fromJson(Map<String, dynamic> json) {
    return PostTee(
      id_club_cancha_tee: json['id_club_cancha_tee'].toString(),
      id_club_cancha: json['id_club_cancha'].toString(),
      start: json['start'].toString(),
      tee: json['tee'].toString(),
      category: json['category'].toString(),
      ida_9h_course_rating: json['ida_9h_course_rating'].toString(),
      ida_9h_slope: json['ida_9h_slope'].toString(),
      vta_9h_course_rating: json['vta_9h_course_rating'].toString(),
      vta_9h_slope: json['vta_9h_slope'].toString(),
      course_rating: json['course_rating'].toString(),
      slope: json['slope'].toString(),
      yards: json['yards'].toString(),
      par: json['par'].toString(),
      p1: json['p1'].toString(),
      p2: json['p2'].toString(),
      p3: json['p3'].toString(),
      p4: json['p4'].toString(),
      p5: json['p5'].toString(),
      p6: json['p6'].toString(),
      p7: json['p7'].toString(),
      p8: json['p8'].toString(),
      p9: json['p9'].toString(),
      p10: json['p10'].toString(),
      p11: json['p11'].toString(),
      p12: json['p12'].toString(),
      p13: json['p13'].toString(),
      p14: json['p14'].toString(),
      p15: json['p15'].toString(),
      p16: json['p16'].toString(),
      p17: json['p17'].toString(),
      p18: json['p18'].toString(),
      d1: json['d1'].toString(),
      d2: json['d2'].toString(),
      d3: json['d3'].toString(),
      d4: json['d4'].toString(),
      d5: json['d5'].toString(),
      d6: json['d6'].toString(),
      d7: json['d7'].toString(),
      d8: json['d8'].toString(),
      d9: json['d9'].toString(),
      d10: json['d10'].toString(),
      d11: json['d11'].toString(),
      d12: json['d12'].toString(),
      d13: json['d13'].toString(),
      d14: json['d14'].toString(),
      d15: json['d15'].toString(),
      d16: json['d16'].toString(),
      d17: json['d17'].toString(),
      d18: json['d18'].toString(),
      h1: json['h1'].toString(),
      h2: json['h2'].toString(),
      h3: json['h3'].toString(),
      h4: json['h4'].toString(),
      h5: json['h5'].toString(),
      h6: json['h6'].toString(),
      h7: json['h7'].toString(),
      h8: json['h8'].toString(),
      h9: json['h9'].toString(),
      h10: json['h10'].toString(),
      h11: json['h11'].toString(),
      h12: json['h12'].toString(),
      h13: json['h13'].toString(),
      h14: json['h14'].toString(),
      h15: json['h15'].toString(),
      h16: json['h16'].toString(),
      h17: json['h17'].toString(),
      h18: json['h18'].toString(),
    );
  }
}
class PostTorneo {
  final String id_torneo;
  final String id_club;
  final String id_club_cancha;
  final String id_user;
  final String codigo_torneo;
  final String id_origen;
  final String title;
  final String sub_title;
  final String modalidad;
  final String game_mode;
  final String batches_count;
  final String batches_holes;
  final String difficulty_day;
  final String start_date;
  final String game_started;
  final String closed_time;
  final String id_torneo_federacion;
  final String alta_time;
  final String alta_user;
  final String mod_time;
  final String mod_user;
  final String club;
  final String cancha;
  final String geolocalizacion;
  List<PostTee> tees;
  PostClub postClub;

  PostTorneo(
      {@required this.id_torneo,
        @required this.id_club,
        @required this.id_club_cancha,
        @required this.id_user,
        @required this.codigo_torneo,
        @required this.id_origen,
        @required this.title,
        @required this.sub_title,
        @required this.modalidad,
        @required this.game_mode,
        @required this.batches_count,
        @required this.batches_holes,
        @required this.difficulty_day,
        @required this.start_date,
        @required this.game_started,
        @required this.closed_time,
        @required this.id_torneo_federacion,
        @required this.alta_time,
        @required this.alta_user,
        @required this.mod_time,
        @required this.mod_user,
        @required this.club,
        @required this.cancha,
        @required this.geolocalizacion,
        @required this.tees,
        @required this.postClub});

  factory PostTorneo.fromJson(Map<String, dynamic> json) {
    return PostTorneo(
      id_torneo: json['id_torneo'] as String,
      id_club: json['id_club'] as String,
      id_club_cancha: json['id_club_cancha'] as String,
      id_user: json['id_user'] as String,
      codigo_torneo: json['codigo_torneo'] as String,
      id_origen: json['id_origen'] as String,
      title: json['title'] as String,
      sub_title: json['sub_title'] as String,
      modalidad: json['modalidad'] as String,
      game_mode: json['game_mode'] as String,
      batches_count: json['batches_count'] as String,
      batches_holes: json['batches_holes'] as String,
      difficulty_day: json['difficulty_day'] as String,
      start_date: json['start_date'] as String,
      game_started: json['game_started'] as String,
      closed_time: json['closed_time'] as String,
      id_torneo_federacion: json['id_torneo_federacion'] as String,
      alta_time: json['alta_time'] as String,
      alta_user: json['alta_user'] as String,
      mod_time: json['mod_time'] as String,
      mod_user: json['mod_user'] as String,
      club: json['club'] as String,
      cancha: json['cancha'] as String,
      geolocalizacion: json['geolocalizacion'] as String,
      tees: (json['tees'].cast<Map<String, dynamic>>())
          .map<PostTee>((json) => PostTee.fromJson(json))
          .toList(),
      postClub: PostClub.fromJson(json['club_object']),
    );
  }
  factory PostTorneo.fromJson2(Map<String, dynamic> json) {
    return PostTorneo(
      id_torneo: json['id_torneo'].toString(),
      id_club: json['id_club'].toString(),
      id_club_cancha: json['id_club_cancha'].toString(),
      id_user: json['id_user'].toString(),
      codigo_torneo: json['codigo_torneo'].toString(),
      id_origen: json['id_origen'].toString(),
      title: json['title'].toString(),
      sub_title: json['sub_title'].toString(),
      modalidad: json['modalidad'].toString(),
      game_mode: json['game_mode'].toString(),
      batches_count: json['batches_count'].toString(),
      batches_holes: json['batches_holes'].toString(),
      difficulty_day: json['difficulty_day'].toString(),
      start_date: json['start_date'].toString(),
      game_started: json['game_started'].toString(),
      closed_time: json['closed_time'].toString(),
      id_torneo_federacion: json['id_torneo_federacion'].toString(),
      alta_time: json['alta_time'].toString(),
      alta_user: json['alta_user'].toString(),
      mod_time: json['mod_time'].toString(),
      mod_user: json['mod_user'].toString(),
      club: json['club'].toString(),
      cancha: json['cancha'].toString(),
      geolocalizacion: json['geolocalizacion'].toString(),
      tees: null,
      postClub: null,
    );
  }
  setTees(@required List<PostTee> postTees) {
    this.tees = postTees;
  }

  setPostClub(@required PostClub postClub) {
    this.postClub = postClub;
  }
}

class PostPractica {
  final String id_torneo;
  final String id_club;
  final String id_club_cancha;
  final String id_user;
  final String codigo_torneo;
  final String id_origen;
  final String title;
  final String sub_title;
  final String modalidad;
  final String game_mode;
  final String batches_count;
  final String batches_holes;
  final String difficulty_day;
  final String start_date;
  final String game_started;
  final String closed_time;
  final String id_torneo_federacion;
  final String alta_time;
  final String alta_user;
  final String mod_time;
  final String mod_user;
  final String club;
  final String cancha;
  final String geolocalizacion;
  List<PostTee> tees;
  PostClub postClub;

  PostPractica(
      {@required this.id_torneo,
      @required this.id_club,
      @required this.id_club_cancha,
      @required this.id_user,
      @required this.codigo_torneo,
      @required this.id_origen,
      @required this.title,
      @required this.sub_title,
      @required this.modalidad,
      @required this.game_mode,
      @required this.batches_count,
      @required this.batches_holes,
      @required this.difficulty_day,
      @required this.start_date,
      @required this.game_started,
      @required this.closed_time,
      @required this.id_torneo_federacion,
      @required this.alta_time,
      @required this.alta_user,
      @required this.mod_time,
      @required this.mod_user,
      @required this.club,
      @required this.cancha,
      @required this.geolocalizacion,
      @required this.tees,
      @required this.postClub});

  factory PostPractica.fromJson(Map<String, dynamic> json) {
    return PostPractica(
      id_torneo: json['id_torneo'] as String,
      id_club: json['id_club'] as String,
      id_club_cancha: json['id_club_cancha'] as String,
      id_user: json['id_user'] as String,
      codigo_torneo: json['codigo_torneo'] as String,
      id_origen: json['id_origen'] as String,
      title: json['title'] as String,
      sub_title: json['sub_title'] as String,
      modalidad: json['modalidad'] as String,
      game_mode: json['game_mode'] as String,
      batches_count: json['batches_count'] as String,
      batches_holes: json['batches_holes'] as String,
      difficulty_day: json['difficulty_day'] as String,
      start_date: json['start_date'] as String,
      game_started: json['game_started'] as String,
      closed_time: json['closed_time'] as String,
      id_torneo_federacion: json['id_torneo_federacion'] as String,
      alta_time: json['alta_time'] as String,
      alta_user: json['alta_user'] as String,
      mod_time: json['mod_time'] as String,
      mod_user: json['mod_user'] as String,
      club: json['club'] as String,
      cancha: json['cancha'] as String,
      geolocalizacion: json['geolocalizacion'] as String,
      tees: (json['tees'].cast<Map<String, dynamic>>())
          .map<PostTee>((json) => PostTee.fromJson(json))
          .toList(),
      postClub: PostClub.fromJson(json['club_object']),
    );
  }
  factory PostPractica.fromJson2(Map<String, dynamic> json) {
    return PostPractica(
      id_torneo: json['id_torneo'].toString(),
      id_club: json['id_club'].toString(),
      id_club_cancha: json['id_club_cancha'].toString(),
      id_user: json['id_user'].toString(),
      codigo_torneo: json['codigo_torneo'].toString(),
      id_origen: json['id_origen'].toString(),
      title: json['title'].toString(),
      sub_title: json['sub_title'].toString(),
      modalidad: json['modalidad'].toString(),
      game_mode: json['game_mode'].toString(),
      batches_count: json['batches_count'].toString(),
      batches_holes: json['batches_holes'].toString(),
      difficulty_day: json['difficulty_day'].toString(),
      start_date: json['start_date'].toString(),
      game_started: json['game_started'].toString(),
      closed_time: json['closed_time'].toString(),
      id_torneo_federacion: json['id_torneo_federacion'].toString(),
      alta_time: json['alta_time'].toString(),
      alta_user: json['alta_user'].toString(),
      mod_time: json['mod_time'].toString(),
      mod_user: json['mod_user'].toString(),
      club: json['club'].toString(),
      cancha: json['cancha'].toString(),
      geolocalizacion: json['geolocalizacion'].toString(),
      tees: null,
      postClub: null,
    );
  }
  setTees(@required List<PostTee> postTees) {
    this.tees = postTees;
  }

  setPostClub(@required PostClub postClub) {
    this.postClub = postClub;
  }
}

class PostControlSC {
  final int id_torneo;
  final int host_id_user;
  final String matricula;
  final int hoyo_nro;
  final int score;

  PostControlSC(
      {@required this.id_torneo,
      @required this.host_id_user,
      @required this.matricula,
      @required this.hoyo_nro,
      @required this.score});

  factory PostControlSC.fromJson(Map<String, dynamic> json) {
    return PostControlSC(
        id_torneo: int.parse(json['id_torneo'].toString()),
        host_id_user: int.parse(json['id_user'].toString()),
        matricula: json['matricula'] as String,
        hoyo_nro: int.parse(json['hoyo_nro'].toString()),
        score: int.parse(json['score'].toString()));
  }
}

class PostLeaderboard {
  final String matricula;
  final String nombre_juga;
  final int hcp_torneo;
  final String path_tee_color;
  final String images;
  final int neto;
  final int stableford;
  final int hoyos_terminados;
  final String status_med;
  final String status_sta;
  final String status_mch;
  final String state_play;
  final String tee_color;

  PostLeaderboard(
      {@required this.matricula,
      @required this.nombre_juga,
      @required this.hcp_torneo,
      @required this.path_tee_color,
      @required this.images,
      @required this.neto,
      @required this.stableford,
      @required this.hoyos_terminados,
      @required this.status_med,
      @required this.status_sta,
      @required this.status_mch,
      @required this.state_play,
      @required this.tee_color});

  factory PostLeaderboard.fromJson(Map<String, dynamic> json) {
    return PostLeaderboard(
        matricula: json['matricula'].toString(),
        nombre_juga: json['nombre_juga'].toString(),
        hcp_torneo: int.parse(json['hcp_torneo'].toString()),
        path_tee_color: json['path_tee_color'].toString(),
        images: json['images'].toString(),
        neto: int.parse(json['neto'].toString()),
        stableford: int.parse(json['stableford'].toString()),
        hoyos_terminados: int.parse(json['hoyos_terminados'].toString()),
        status_med: json['status_med'].toString(),
        status_sta: json['status_sta'].toString(),
        status_mch: json['status_mch'].toString(),
        state_play: json['state_play'].toString(),
        tee_color: json['tee_color'].toString());
  }
}
