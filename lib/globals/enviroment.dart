
import 'dart:io';

class Enviroment{
  static String urlApi =  Platform.isAndroid ? 'http://10.0.0.235:3001/api' : 'http://localhost:3001/api';
  static String urlSocket =  Platform.isAndroid ? 'http://10.0.0.235:3001' : 'http://localhost:3001';
}