import 'package:flutter/material.dart';
import 'package:fe/routes/app_routes.dart';
import 'package:fe/views/home_screen.dart';
import 'package:fe/cau1/views/cau1_screen.dart';
import 'package:fe/cau2/views/login_screen.dart';
import 'package:fe/cau2/views/register_screen.dart';
import 'package:fe/cau2/views/cau2_authenticated_home_screen.dart';
import 'package:fe/cau3/views/cau3_screen.dart';
import 'package:fe/cau4/views/cau4_screen.dart';
import 'package:fe/cau5/views/cau5_screen.dart';
import 'package:fe/cau6/views/cau6_screen.dart';
import 'package:fe/cau7/views/cau7_screen.dart';
import 'package:fe/cau8/views/cau8_screen.dart';
import 'package:fe/cau9/views/cau9_screen.dart';
import 'package:fe/cau10/views/cau10_screen.dart';

class AppPages {
  static final Map<String, Widget Function(BuildContext)> routes = {
    AppRoutes.home: (_) => const HomeScreen(),
    AppRoutes.login: (_) => const LoginScreen(),
    AppRoutes.register: (_) => const RegisterScreen(),
    AppRoutes.cau1: (_) => const Cau1Screen(),
    AppRoutes.cau2: (_) => const Cau2AuthenticatedHomeScreen(),
    AppRoutes.cau3: (_) => const Cau3Screen(),
    AppRoutes.cau4: (_) => const Cau4Screen(),
    AppRoutes.cau5: (_) => const Cau5Screen(),
    AppRoutes.cau6: (_) => const Cau6Screen(),
    AppRoutes.cau7: (_) => const Cau7Screen(),
    AppRoutes.cau8: (_) => const Cau8Screen(),
    AppRoutes.cau9: (_) => const Cau9Screen(),
    AppRoutes.cau10: (_) => const Cau10Screen(),
  };
}
