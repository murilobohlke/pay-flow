import 'package:flutter/cupertino.dart';
import 'package:payflow/shared/models/boleto_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExtractListController {
  final boletosNotifier = ValueNotifier<List<BoletoModel>>(<BoletoModel>[]);

  List<BoletoModel> get boletos => boletosNotifier.value;
  set boletos(List<BoletoModel> value) => boletosNotifier.value = value;

  ExtractListController() {
    getBoletos();
  }

  Future<void> saveBoleto(BoletoModel model) async {
    try {
      final instance = await SharedPreferences.getInstance();
      final boletos = instance.getStringList('extratos') ?? <String>[];
      boletos.add(model.toJson());
      await instance.setStringList('extratos', boletos);
      await deleteBoleto(model);
      return;
    } catch (e) {
      print(e);
    }
  }

  Future<void> getBoletos() async {
    try {
      final instance = await SharedPreferences.getInstance();
      final response = instance.getStringList('extratos') ?? <String>[];
      boletos = response.map((e) => BoletoModel.fromJson(e)).toList();
    } catch (e) {
      boletos = <BoletoModel>[];
    }
  }

  Future<void> deleteBoleto(BoletoModel model) async {
    try {
      final instance = await SharedPreferences.getInstance();
      final response = instance.getStringList('boletos') ?? <String>[];
      //boletos = response.map((e) => BoletoModel.fromJson(e)).toList();

      response.remove(model.toJson());

      await instance.setStringList('boletos', response);
    } catch (e) {
      print(e);
    }
  }
}
