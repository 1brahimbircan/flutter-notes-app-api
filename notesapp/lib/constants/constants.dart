import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Constants {

  //Tema Rengi
  static const Color temaRenk = Colors.black;
  //Yazi Rengi
  static const Color yaziRenk = Colors.white;

  //AppBar Başlık
  static const String appBaslik = "CookAR";
  //Card Border Radius
  static final BorderRadius borderRadius = BorderRadius.circular(10);
  //AppBar Text Style
  static final TextStyle styleBaslik = GoogleFonts.inter(
      fontSize: 20, fontWeight: FontWeight.w600, color: yaziRenk);
  //Yanlardan Padding
  static const EdgeInsets h10v5padding =
      EdgeInsets.symmetric(horizontal: 10,vertical: 5);
}
