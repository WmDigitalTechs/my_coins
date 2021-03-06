import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:my_coins/app/shared/util/value/const_srtring.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../shared/models/coins_model.dart';
import '../../../shared/repository/coin_repository.dart';
import '../../../shared/util/general_functions.dart';
import '../../../shared/util/value/const_colors.dart';

part 'home_store.g.dart';

// -> User Case
class HomeStore = HomeStoreBase with _$HomeStore;

abstract class HomeStoreBase with Store {
  final genFunctions = Modular.get<GeneralFunctions>();
  final CoinRepository repository;

  @observable
  ObservableFuture<List<CoinModel>>? coins;

  HomeStoreBase(this.repository) {
    fetchCoins(itemSelect);
    changeVersion();
  }

  @action
  fetchCoins(String? typeConin) {
    if (typeConin == null) typeConin = 'USD';
    coins = repository.getAllCoins(typeConin)?.asObservable();
    changeDateUpgrade("${coins?.value?[0].createDate}");
  }

  @observable
  int currentIndex = 0;
  @action
  changePage(int index) => currentIndex = index;

  @observable
  String dateUpgrade = "";
  @action
  changeDateUpgrade(String? value) =>
      value != null ? dateUpgrade = value : dateUpgrade;

  launchURL(_url) async {
    final url = Uri.encodeFull(_url);
    await launch(url);
  }

  @observable
  String? version = "";
  @action
  changeVersion() async {
    version = await genFunctions.getBuildAndVersion();
  }

  @observable
  String? itemSelect = 'USD';
  @action
  changesItenSelect(String? value) async {
    itemSelect = value;
    fetchCoins(value);
  }

  @observable
  List<DropdownMenuItem<String>> listaItensDrop = [];
  @action
  changeslistDropdownMenuItem(List<DropdownMenuItem<String>> value) =>
      listaItensDrop = value;

  @observable
  Color? colorLinkEmail = ConstColors.colorLavenderFloral;
  @observable
  Color? colorLinkDin = ConstColors.colorLavenderFloral;
  @observable
  Color? colorLinkGit = ConstColors.colorLavenderFloral;
  @observable
  Color? colorLinkDoc = ConstColors.colorLavenderFloral;
  
  
  @action
  changesColorLink(String text) {
    switch (text) {
      case ConstString.email:
        colorLinkEmail = ConstColors.colorSkyMagenta;
        break;
      case ConstString.linkDin:
        colorLinkDin = ConstColors.colorSkyMagenta;
        break;
      case ConstString.gitHub:
        colorLinkGit = ConstColors.colorSkyMagenta;
        break;
      case ConstString.docFlutter:
        colorLinkDoc = ConstColors.colorSkyMagenta;
        break;
    }
  }

  @observable
  Color? colorLinkEvaluation = ConstColors.colorLavenderFloral;
  @action
  changesColorLinkEvaluation() {
     return  colorLinkEvaluation = ConstColors.colorSkyMagenta;
  }

  setFalseProgress() {
    changesProgressLink(false);
  }

  @observable
  bool progressLink = false;
  @action
  changesProgressLink(bool value) => progressLink = value;

  @computed
  // ignore: unnecessary_null_comparison
  bool get isValid => valueToConvert == null;

  String? valueToConvert() {
    if (textValidat == null || textValidat!.isEmpty) {
      return "?? obrigatorio um valor para convers??o";
    } else {
      changesValueConvertion();
    }
    return null;
  }

  @observable
  String? textValidat = '0';
  @action
  changesTextValidat(String? value) {
    print(
        "Chegou no controller @@@@@  -> $value, \n  Eu acredito em mim Choppin !");
    return textValidat = value;
  }

  @observable
  String? priceCoin = "0";
  @action
  changesPriceCoin(String? value) {
    priceCoin = genFunctions.formatNumberBr(value!);
    return priceCoin;
  }

  @observable
  String? valueConvertion = "0";
  @action
  changesValueConvertion() {
    var code = coins?.value?[0].code;
    if (isReverseConversion) {
      
      if (coins != null && code == "BTC" ) {
        valueConvertion =
            genFunctions.calcRealToBitCoin(priceCoin, textValidat);
      }if (coins != null && code == "LTC") {
        valueConvertion =
            genFunctions.calcRealToLiteCoin(priceCoin, textValidat);
      } else {
        valueConvertion = genFunctions.calcRealToCoin(priceCoin, textValidat);
      }
    
    } else {

      if (coins != null && code == "BTC") {
        valueConvertion =
            genFunctions.calcBitCoinToReal(priceCoin, textValidat);
      }else if (coins != null && code == "LTC") {
        valueConvertion =
            genFunctions.calcLiteCoinToReal(priceCoin, textValidat);
      }else {
        valueConvertion = genFunctions.calcCoinToReal(priceCoin, textValidat);
      }
    }
    return valueConvertion;
  }

  @observable
  bool isReverseConversion = true;
  @action
  changesIsReverseConversion() {
    if (isReverseConversion) {
      isReverseConversion = false;
    } else if (isReverseConversion == false) {
      isReverseConversion = true;
    }

    return isReverseConversion;
  }
}
