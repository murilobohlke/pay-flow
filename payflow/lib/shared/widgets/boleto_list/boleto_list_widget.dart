import 'package:animated_card/animated_card.dart';
import 'package:flutter/material.dart';
import 'package:payflow/shared/models/boleto_model.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';
import 'package:payflow/shared/widgets/boleto_list/boleto_list_controller.dart';
import 'package:payflow/shared/widgets/boleto_modal/boleto_modal_widget.dart';
import 'package:payflow/shared/widgets/boleto_tile/boleto_tile_widget.dart';

class BoletoListWidget extends StatefulWidget {
  final BoletoListController controller;
  const BoletoListWidget({Key? key, required this.controller}) : super(key: key);

  @override
  _BoletoListWidgetState createState() => _BoletoListWidgetState();
}

class _BoletoListWidgetState extends State<BoletoListWidget> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<BoletoModel>>(
      valueListenable: widget.controller.boletosNotifier,
      builder: (_, boletos, __) => boletos.length != 0 ?
      Column(
        children: boletos.map((e) => BoletoTileWidget(
          data: e, onTap: () {
            showModalBottomSheet(
            context: context,
            builder: (_) {
              return BoletoModalWidget(data: e,);
          });
        },)).toList(),
      ) : AnimatedCard(
        direction: AnimatedCardDirection.left,
        child: Container(width: double.infinity, child: Text('Você não tem boletos que irão vencer!', style: TextStyles.trailingRegular, textAlign: TextAlign.center,))
      ),
    );
  }
}
