import 'package:flutter/material.dart';
import 'package:gastosappg8/models/gasto_model.dart';
import 'package:gastosappg8/widgets/edit_modal.dart';

class ItemGastoWidget extends StatelessWidget {
  final GastoModel gasto;

  ItemGastoWidget({required this.gasto});

  @override
  Widget build(BuildContext context) {
    Map<String, String> imageMap = {
      "Alimentos": "assets/images/alimentos.webp",
      "Bancos y Seguro": "assets/images/bancos.webp",
      "Entretenimiento": "assets/images/entretenimiento.webp",
      "Otros": "assets/images/otros.webp",
      "Servicios": "assets/images/servicios.webp",
      "Entretenimiento": "assets/images/entretenimiento.webp",
    };

    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        leading: Image.asset(
          imageMap[gasto.type] ?? "assets/images/otros.webp",
          height: 40,
          width: 40,
        ),
        title: Text(
          gasto.title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        subtitle: Text(
          gasto.datetime,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w400,
          ),
        ),
        trailing: Text(
          "S/ ${gasto.price} ",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        onTap: () {
          _showEditModal(context, gasto);
        },
      ),
    );
  }

  void _showEditModal(BuildContext context, GastoModel gasto) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: EditGastoModal(gasto: gasto),
        );
      },
    );
  }
}
