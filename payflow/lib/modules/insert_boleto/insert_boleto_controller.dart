import 'package:flutter/cupertino.dart';
import 'package:payflow/modules/home/home_controller.dart';
import 'package:payflow/shared/models/boleto_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InsertBoletoController {
  final formKey = GlobalKey<FormState>();
  final controller = HomeController();

  BoletoModel model = BoletoModel();

  String? validateName(String? value) =>
      value?.isEmpty ?? true ? "O nome não pode ser vazio" : null;
  String? validateVencimento(String? value) =>
      value?.isEmpty ?? true ? "A data de vencimento não pode ser vazio" : null;
  String? validateValor(double value) =>
      value == 0 ? "Insira um valor maior que R\$ 0,00" : null;
  String? validateCodigo(String? value) =>
      value?.isEmpty ?? true ? "O código do boleto não pode ser vazio" : null;

  void onChange(
      {String? name, String? dueData, double? value, String? barcode}) {
    model = model.copyWith(
        name: name, dueData: dueData, value: value, barcode: barcode);
  }

  Future<void> saveBoleto() async {
    try {
      final instance = await SharedPreferences.getInstance();
      final boletos = instance.getStringList('boletos') ?? <String>[];
      boletos.add(model.toJson());
      await instance.setStringList('boletos', boletos);
      return;
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteBoleto(BoletoModel model) async {
    try {
      final instance = await SharedPreferences.getInstance();
      final response = instance.getStringList('boletos') ?? <String>[];
      //boletos = response.map((e) => BoletoModel.fromJson(e)).toList();

      response.remove(model.toJson());
      controller.setPage(1);

      await instance.setStringList('boletos', response);
    } catch (e) {
      print(e);
    }
  }

  Future<bool> cadastrarBoleto() async {
    final form = formKey.currentState;

    if (form!.validate()) {
      await saveBoleto();

      return true;
    }
    return false;
  }
}
