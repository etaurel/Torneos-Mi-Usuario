import 'package:flutter/foundation.dart';
import 'package:golfguidescorecard/models/postTorneo.dart';
import 'package:golfguidescorecard/utilities/user-funtions.dart';

class PostUser {
  final String idjuga_arg;
  final String matricula;
  String nombre_juga;
  String hcp;
  final String hcp3;
  String celular;
  String email;
  final String idclub;
  String sexo;
  final String images;
  final String pais_juga;
  int level_security;
  final String token;
  PostTee _postTee;

  PostTee get postTee => _postTee;

  set postTee(PostTee postTee) {
    _postTee = postTee;
  }
  String _pathTeeColor;

  String get pathTeeColor => _pathTeeColor;

  set pathTeeColor(String pathTeeColor) {
    _pathTeeColor = pathTeeColor;
  }

  setHcp(hcp){
    this.hcp=hcp;
  }
  setLevelSecurity(levelSecurity){
    this.level_security=levelSecurity;
  }

  PostUser({
    @required this.idjuga_arg,
    @required this.matricula,
    @required this.nombre_juga,
    @required this.hcp,
    @required this.hcp3,
    @required this.celular,
    @required this.email,
    @required this.idclub,
    @required this.sexo,
    @required this.images,
    @required this.pais_juga,
    @required this.level_security,
    @required this.token,
  });

  factory PostUser.fromJson(Map<String, dynamic> json) {
    return PostUser(
      idjuga_arg: json['id_user'] as String,
      matricula: json['matricula'] as String,
      nombre_juga: json['nombre'] as String,
      hcp: json['hcp'] as String,
      hcp3: json['hcp_3'] as String,
      celular: json['celular'] as String,
      email: json['email'] as String,
      idclub: json['club'] as String,
      sexo: json['sexo'] as String,
      images: UserFunctions.IsDamaImage(json['imagen'] as String,json['sexo'] as String) ,
      pais_juga: json['pais'] as String,
      level_security: int.parse(json['level_security']),
      token: json['token'] as String,
    );
  }


}

class PostJuga {
  final String idjuga_arg;
  final String matricula;
  final String nombre_juga;
  final String hcp;
  final String hcp3;
  final String celular;
  final String email;
  final String idclub;
  final String sexo;
  final String images;
  final String pais_juga;
  final int level_security;

  PostTee _postTee;
  PostTee get postTee => _postTee;
  set postTee(PostTee postTee) {
    _postTee = postTee;
  }

  String _hcpTorneo= '';
  String get hcpTorneo {
    return _hcpTorneo;
  }
  void set hcpTorneo(String newHcpTorneo) {
    _hcpTorneo = newHcpTorneo;
  }


  String _pathTeeColor='';
  String get pathTeeColor => _pathTeeColor;
  set pathTeeColor(String pathTeeColor) {
    _pathTeeColor = pathTeeColor;
  }

  PostJuga(
      {@required this.idjuga_arg,
        @required this.matricula,
        @required this.nombre_juga,
        @required this.hcp,
        @required this.hcp3,
        @required this.celular,
        @required this.email,
        @required this.idclub,
        @required this.sexo,
        @required this.images,
        @required this.pais_juga,
        @required this.level_security})
  {
    this.hcpTorneo=hcp;
  }

  factory PostJuga.fromJson(Map<String, dynamic> json) {

    return PostJuga(
        idjuga_arg: json['id_user'] as String,
        matricula: json['matricula'] as String,
        nombre_juga: json['nombre'] as String,
        hcp: json['hcp'] as String,
        hcp3: json['hcp_3'] as String,
        celular: json['celular'] as String,
        email: json['email'] as String,
        idclub: json['club'] as String,
        sexo: json['sexo'] as String,
        images: UserFunctions.IsDamaImage(json['imagen'] as String,json['sexo'] as String) , //json['imagen'] as String,
        pais_juga: json['id_pais'] as String,
        level_security: int.parse(json['level_security'])
    );
  }

  factory PostJuga.fromPostUser(PostUser postUserIn) {

    return PostJuga(
        idjuga_arg:postUserIn.idjuga_arg,
        matricula: postUserIn.matricula,
        nombre_juga: postUserIn.nombre_juga,
        hcp: postUserIn.hcp,
        hcp3: postUserIn.hcp3,
        celular: postUserIn.celular,
        email:postUserIn.email,
        idclub: postUserIn.idclub,
        sexo: postUserIn.sexo,
        images: postUserIn.images,
        pais_juga: postUserIn.pais_juga,
        level_security: postUserIn.level_security
    );
  }

}

class PostClub {
  final String par;
  final String slope;
  final String course_rating;
  final String nombre;
  final String id_localidad;
  final String id_provincia;
  final String id_pais;
  final String imagen;
  final String logo;
  final String id_club;
  final String id_club_cancha;
  final String nombre_club;
  final String telefono;
  final String dir_calle;
  final String dir_numero;
  final String dir_cp;
  final String geolocalizacion;

  PostClub({
    @required this.par,
    @required this.slope,
    @required this.course_rating,
    @required this.nombre,
    @required this.id_localidad,
    @required this.id_provincia,
    @required this.id_pais,
    @required this.imagen,
    @required this.logo,
    @required this.id_club,
    @required this.id_club_cancha,
    @required this.nombre_club,
    @required this.telefono,
    @required this.dir_calle,
    @required this.dir_numero,
    @required this.dir_cp,
    @required this.geolocalizacion,
  });

  factory PostClub.fromJson(Map<String, dynamic> json) {
    return PostClub(
      par: json['par'] as String,
      slope: json['slope'] as String,
      course_rating: json['course_rating'] as String,
      id_localidad: json['id_localidad'] as String,
      id_provincia: json['id_provincia'] as String,
      id_pais: json['id_pais'] as String,
      nombre: json['nombre_ext'] as String,
      imagen: json['imagen'] as String,
      logo: json['logo'] as String,
      id_club_cancha: json['id_club_cancha'] as String,
      id_club: json['id_club'] as String,
      nombre_club: json['nombre'] as String,
      telefono: json['telefono'] as String,
      dir_calle: json['dir_calle'] as String,
      dir_numero: json['dir_numero'] as String,
      dir_cp: json['dir_cp'] as String,
      geolocalizacion: json['geolocalizacion'] as String,
    );
  }
}




// import 'package:flutter/foundation.dart';
// import 'package:golfguidescorecard/models/postTorneo.dart';
// import 'package:golfguidescorecard/utilities/user-funtions.dart';
//
// class PostUser {
//   final String idjuga_arg;
//   final String matricula;
//   final String nombre_juga;
//   String hcp;
//   final String hcp3;
//   String celular;
//   String email;
//   final String idclub;
//   final String sexo;
//   final String images;
//   final String pais_juga;
//   int level_security;
//   final String token;
//   PostTee _postTee;
//
//   PostTee get postTee => _postTee;
//
//   set postTee(PostTee postTee) {
//     _postTee = postTee;
//   }
//   String _pathTeeColor;
//
//   String get pathTeeColor => _pathTeeColor;
//
//   set pathTeeColor(String pathTeeColor) {
//     _pathTeeColor = pathTeeColor;
//   }
//
//   setHcp(hcp){
//     this.hcp=hcp;
//   }
//   setLevelSecurity(levelSecurity){
//     this.level_security=levelSecurity;
//   }
//
//   PostUser({
//     @required this.idjuga_arg,
//     @required this.matricula,
//     @required this.nombre_juga,
//     @required this.hcp,
//     @required this.hcp3,
//     @required this.celular,
//     @required this.email,
//     @required this.idclub,
//     @required this.sexo,
//     @required this.images,
//     @required this.pais_juga,
//     @required this.level_security,
//     @required this.token,
//   });
//
//   factory PostUser.fromJson(Map<String, dynamic> json) {
//     return PostUser(
//       idjuga_arg: json['id_user'] as String,
//       matricula: json['matricula'] as String,
//       nombre_juga: json['nombre'] as String,
//       hcp: json['hcp'] as String,
//       hcp3: json['hcp_3'] as String,
//       celular: json['celular'] as String,
//       email: json['email'] as String,
//       idclub: json['club'] as String,
//       sexo: json['sexo'] as String,
//       images: UserFunctions.IsDamaImage(json['imagen'] as String,json['sexo'] as String) ,
//       pais_juga: json['pais'] as String,
//       level_security: int.parse(json['level_security']),
//       token: json['token'] as String,
//     );
//   }
//
//
// }
//
// class PostJuga {
//   final String idjuga_arg;
//   final String matricula;
//   final String nombre_juga;
//   final String hcp;
//   final String hcp3;
//   final String celular;
//   final String email;
//   final String idclub;
//   final String sexo;
//   final String images;
//   final String pais_juga;
//   final int level_security;
//
//   PostTee _postTee;
//   PostTee get postTee => _postTee;
//   set postTee(PostTee postTee) {
//     _postTee = postTee;
//   }
//
//   String _hcpTorneo= '';
//   String get hcpTorneo {
//     return _hcpTorneo;
//   }
//   void set hcpTorneo(String newHcpTorneo) {
//     _hcpTorneo = newHcpTorneo;
//   }
//
//
//   String _pathTeeColor='';
//   String get pathTeeColor => _pathTeeColor;
//   set pathTeeColor(String pathTeeColor) {
//     _pathTeeColor = pathTeeColor;
//   }
//
//   PostJuga(
//       {@required this.idjuga_arg,
//       @required this.matricula,
//       @required this.nombre_juga,
//       @required this.hcp,
//       @required this.hcp3,
//       @required this.celular,
//       @required this.email,
//       @required this.idclub,
//       @required this.sexo,
//       @required this.images,
//       @required this.pais_juga,
//       @required this.level_security})
//   {
//     this.hcpTorneo=hcp;
//   }
//
//   factory PostJuga.fromJson(Map<String, dynamic> json) {
//
//     return PostJuga(
//       idjuga_arg: json['id_user'] as String,
//       matricula: json['matricula'] as String,
//       nombre_juga: json['nombre'] as String,
//       hcp: json['hcp'] as String,
//       hcp3: json['hcp_3'] as String,
//       celular: json['celular'] as String,
//       email: json['email'] as String,
//       idclub: json['club'] as String,
//       sexo: json['sexo'] as String,
//       images: UserFunctions.IsDamaImage(json['imagen'] as String,json['sexo'] as String) , //json['imagen'] as String,
//       pais_juga: json['id_pais'] as String,
//       level_security: int.parse(json['level_security'])
//     );
//   }
//
//   factory PostJuga.fromPostUser(PostUser postUserIn) {
//
//     return PostJuga(
//         idjuga_arg:postUserIn.idjuga_arg,
//         matricula: postUserIn.matricula,
//         nombre_juga: postUserIn.nombre_juga,
//         hcp: postUserIn.hcp,
//         hcp3: postUserIn.hcp3,
//         celular: postUserIn.celular,
//         email:postUserIn.email,
//         idclub: postUserIn.idclub,
//         sexo: postUserIn.sexo,
//         images: postUserIn.images,
//         pais_juga: postUserIn.pais_juga,
//         level_security: postUserIn.level_security
//     );
//   }
//
// }
//
// class PostClub {
//   final String par;
//   final String slope;
//   final String course_rating;
//   final String nombre;
//   final String id_localidad;
//   final String id_provincia;
//   final String id_pais;
//   final String imagen;
//   final String logo;
//   final String id_club;
//   final String id_club_cancha;
//   final String nombre_club;
//   final String telefono;
//   final String dir_calle;
//   final String dir_numero;
//   final String dir_cp;
//   final String geolocalizacion;
//
//   PostClub({
//     @required this.par,
//     @required this.slope,
//     @required this.course_rating,
//     @required this.nombre,
//     @required this.id_localidad,
//     @required this.id_provincia,
//     @required this.id_pais,
//     @required this.imagen,
//     @required this.logo,
//     @required this.id_club,
//     @required this.id_club_cancha,
//     @required this.nombre_club,
//     @required this.telefono,
//     @required this.dir_calle,
//     @required this.dir_numero,
//     @required this.dir_cp,
//     @required this.geolocalizacion,
//   });
//
//   factory PostClub.fromJson(Map<String, dynamic> json) {
//     return PostClub(
//       par: json['par'] as String,
//       slope: json['slope'] as String,
//       course_rating: json['course_rating'] as String,
//       id_localidad: json['id_localidad'] as String,
//       id_provincia: json['id_provincia'] as String,
//       id_pais: json['id_pais'] as String,
//       nombre: json['nombre_ext'] as String,
//       imagen: json['imagen'] as String,
//       logo: json['logo'] as String,
//       id_club_cancha: json['id_club_cancha'] as String,
//       id_club: json['id_club'] as String,
//       nombre_club: json['nombre'] as String,
//       telefono: json['telefono'] as String,
//       dir_calle: json['dir_calle'] as String,
//       dir_numero: json['dir_numero'] as String,
//       dir_cp: json['dir_cp'] as String,
//       geolocalizacion: json['geolocalizacion'] as String,
//     );
//   }
// }
//
//
