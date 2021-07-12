import 'package:flutter/material.dart';
import 'package:shop_in/login/login_screen.dart';
import 'package:shop_in/shared/network/local/cache_helper.dart';

void signOut(context) {
  CacheHelper.removeData(key: 'token').then((value) {
    if (value)
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
          (route) => false);
  });
}

String token = '';
