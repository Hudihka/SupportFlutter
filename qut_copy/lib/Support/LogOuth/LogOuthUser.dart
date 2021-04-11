import 'package:flutter/material.dart';
import 'package:qut/Support/LogOuth/DefaultUtils.dart';
import 'package:qut/Support/LogOuth/LastContext.dart';
import 'package:qut/imports.dart';

class LogOuthUser {
  static logOuth() {
    DefaultUtils.shared.deleteAll();

    BuildContext context = LastContext.getContext;

    Navigator.of(context).popUntil((route) => route.isFirst);

    final cubit = MiniPlayerSingelton.shared.getCubit;
    cubit.newSelectedIndex(0);
    cubit.killMedia();

    
  }
}
