import 'package:flutter/material.dart';
import 'package:gastosappg8/db/db_admin.dart';
import 'package:gastosappg8/widgets/field_modal_widget.dart';
import 'package:gastosappg8/widgets/item_type_widget.dart';

import '../models/gasto_model.dart';
import '../utils/data_general.dart';

class EditGastoModal extends StatefulWidget {
  final GastoModel gasto;

  EditGastoModal({required this.gasto});

  @override
  _EditGastoModalState createState() => _EditGastoModalState();
}

class _EditGastoModalState extends State<EditGastoModal> {
  late TextEditingController _productController;
  late TextEditingController _priceController;
  late TextEditingController _dateController;
  late String typeSelected;

  @override
  void initState() {
    super.initState();
    _productController = TextEditingController(text: widget.gasto.title);
    _priceController =
        TextEditingController(text: widget.gasto.price.toString());
    _dateController = TextEditingController(text: widget.gasto.datetime);
    typeSelected = widget.gasto.type;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(34),
          topRight: Radius.circular(34),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Edita el gasto"),
            SizedBox(height: 16),
            FieldModalWidget(
                hint: "Ingresa el título", controller: _productController),
            FieldModalWidget(
                hint: "Ingresa el monto",
                controller: _priceController,
                isNumberKeryboard: true),
            FieldModalWidget(
              hint: "Selecciona una fecha",
              controller: _dateController,
              isDatePicker: true,
              function: () {
                showDateTimePicker();
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                alignment: WrapAlignment.center,
                children: types
                    .map((e) => ItemTypeWidget(
                          data: e,
                          isSelected: e["name"] == typeSelected,
                          tap: () {
                            setState(() {
                              typeSelected = e["name"];
                            });
                          },
                        ))
                    .toList(),
              ),
            ),
            _buildButtonSave(),
          ],
        ),
      ),
    );
  }

  void showDateTimePicker() async {
    DateTime? datePicker = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2030),
    );
    if (datePicker != null) {
      _dateController.text = datePicker.toString();
    }
  }

  Widget _buildButtonSave() {
    return SizedBox(
      width: double.infinity,
      height: 40,
      child: ElevatedButton(
        onPressed: () {
          GastoModel updatedGasto = GastoModel(
            title: _productController.text,
            price: double.parse(_priceController.text),
            datetime: _dateController.text,
            type: typeSelected,
          );

          DBAdmin().updGasto(widget.gasto.id!, updatedGasto).then((value) {
            if (value > 0) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Gasto actualizado correctamente"),
                ),
              );
              Navigator.pop(context);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Error al actualizar el gasto"),
                ),
              );
            }
          });
        },
        child: Text("Guardar"),
      ),
    );
  }
}
