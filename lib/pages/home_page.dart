import 'package:flutter/material.dart';
import 'package:gastosappg8/db/db_admin.dart';
import 'package:gastosappg8/generated/l10n.dart';
import 'package:gastosappg8/models/gasto_model.dart';
import 'package:gastosappg8/widgets/item_gasto_widget.dart';
import 'package:gastosappg8/widgets/register_modal.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<GastoModel> gastos = [];
  GastoModel gasto1 = GastoModel(
      title: "TITULO", datetime: "12/1/12", price: 12, type: "Alimentos");
  Widget busquedaWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Buscar por título",
          hintStyle: TextStyle(
            color: Colors.black.withOpacity(0.4),
            fontSize: 14,
          ),
          filled: true,
          fillColor: Colors.black.withOpacity(0.05),
          contentPadding: EdgeInsets.all(16),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(16),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }

  showRegisterModal() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: RegisterModal(),
        );
      },
    ).then((value) {
      getDataFromDB();
    });
  }

  // DBAdmin dbAdmin = DBAdmin();

  Future<void> getDataFromDB() async {
    gastos = await DBAdmin().obtenerGastos();
    setState(() {});
  }

  @override
  void initState() {
    getDataFromDB();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     // dbAdmin.insertarGasto();
        //     DBAdmin().obtenerGastos();
        //     // dbAdmin.obtenerGastos();
        //     // DBAdmin().updGasto();
        //     // DBAdmin().delGasto();
        //   },
        // ),
        body: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    showRegisterModal();
                    // dbAdmin.checkDatabase();
                    // dbAdmin.insertarGasto();
                    // DBAdmin().insertarGasto();
                  },
                  child: Container(
                    color: Colors.black,
                    height: 100,
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          "Agregar",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(top: 16, left: 16, right: 16),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(35),
                        bottomRight: Radius.circular(35),
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Resumen de gastos",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Gestiona tus gastos de mejor forma",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.black45,
                          ),
                        ),
                        Text(S.of(context).helloAlquien("JUAN")),
                        busquedaWidget(),
                        Expanded(
                          child: ListView.builder(
                            itemCount: gastos.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ItemGastoWidget(
                                gasto: gastos[index],
                              );
                            },
                          ),
                        ),

                        // ListTile(
                        //   title: Text("Compras en el super"),
                        //   subtitle: Text("14/01/2025 23:21"),
                        // ),
                        // ItemGastoWidget(gasto: gasto1),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 75,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
