import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Styles {
  static const Color background = Color(0xff484B5B);
  static const Color date = Color(0xff32333E);
  static const Color textoFecha = Color(0xff9B9EAD);
  static const Color container = Color(0x1fD8D8D8);
  static const Color clima = Color(0xffFFBD00);

  static TextStyle get textCiudad =>
      GoogleFonts.getFont('Poppins', color: Colors.white, fontSize: 15);
  static TextStyle temp =
      TextStyle(color: textoFecha, fontSize: 30, fontWeight: FontWeight.bold);
}
