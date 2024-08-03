import 'package:flutter/material.dart';
import 'package:gastosappg8/models/gasto_model.dart';
import 'package:gastosappg8/widgets/edit_modal.dart';

class ItemGastoWidget extends StatelessWidget {
  GastoModel gasto;

  ItemGastoWidget({required this.gasto});

  @override
  Widget build(BuildContext context) {
    String? imageAsset = types.firstWhere(
      (type) => type['name'] == gasto.type,
      orElse: () => {"image": "assets/images/otros.webp"},
    )['image'];

    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        leading: Image.asset(
          imageAsset!,
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

List<Map<String, dynamic>> types = [
  {
    "id": 1,
    "name": "Alimentos",
    "image": "assets/images/alimentos.webp",
  },
  {
    "id": 2,
    "name": "Banco y Seguro",
    "image": "assets/images/bancos.webp",
  },
  {
    "id": 3,
    "name": "Entretenimiento",
    "image": "assets/images/entretenimiento.webp",
  },
  {
    "id": 4,
    "name": "Servicios",
    "image": "assets/images/servicios.webp",
  },
  {
    "id": 5,
    "name": "Otros",
    "image": "assets/images/otros.webp",
  },
];
