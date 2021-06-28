import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:payflow/modules/insert_boleto/insert_boleto_controller.dart';
import 'package:payflow/shared/models/boleto_model.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';
import 'package:payflow/shared/widgets/extract_list/extract_list_controller.dart';

class BoletoModalWidget extends StatelessWidget {
  final BoletoModel data;
  const BoletoModalWidget({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = ExtractListController();
    final controllerBoleto = InsertBoletoController();
    return Container(
      height: 250,
      color: AppColors.background,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 20),
            color: AppColors.stroke,
            height: 3,
            width: 80,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 60, right: 60),
            child: Text(
              'O boleto ${data.name!} no valor de R\$ ${data.value!.toStringAsFixed(2)} foi pago?',
              style: TextStyles.textModal,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 3,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Ainda não'),
                    style: ElevatedButton.styleFrom(
                        primary: AppColors.shape,
                        textStyle: TextStyles.buttonPrimary),
                  ),
                ),
                Container(
                    width: MediaQuery.of(context).size.width / 3,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () async {
                        await controller.saveBoleto(data);
                        Navigator.pop(context);
                      },
                      child: Text('Sim'),
                      style: ElevatedButton.styleFrom(
                          onPrimary: Colors.white,
                          textStyle: TextStyles.buttonPrimary),
                    )),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(width: 2, color: AppColors.stroke),
              ),
              color: AppColors.shape,
            ),
            margin: EdgeInsets.only(top: 10),
            width: double.infinity,
            child: TextButton(
                onPressed: () {
                  controllerBoleto.deleteBoleto(data);
                  Navigator.pop(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      FontAwesomeIcons.trashAlt,
                      color: Colors.red,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Excluir',
                      style: TextStyles.buttonBoldPrimary,
                    )
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
