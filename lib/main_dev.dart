import 'package:edukasi_pot/config/config.dart';
import 'package:edukasi_pot/config/dev.dart';

import './main.dart';

void main() {
  Config().loadFromMap(settings);
  baseMain();
}