import 'package:flutter/material.dart';
import 'package:payflow/shared/models/boleto_model.dart';
import 'package:payflow/shared/widgets/boleto_tile/boleto_tile_widget.dart';
import 'package:payflow/shared/widgets/extract_list/extract_list_controller.dart';


class ExtractListWidget extends StatefulWidget {
  final ExtractListController controller;
  const ExtractListWidget({Key? key, required this.controller}) : super(key: key);

  @override
  _ExtractListWidgetState createState() => _ExtractListWidgetState();
}

class _ExtractListWidgetState extends State<ExtractListWidget> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<BoletoModel>>(
      valueListenable: widget.controller.boletosNotifier,
      builder: (_, boletos, __) => Column(
        children: boletos.map((e) => BoletoTileWidget(data: e)).toList(),
      ),
    );
  }
}
