import 'package:ecommerce_app/network/api/url_api.dart';
import 'package:ecommerce_app/network/model/invoice_model.dart';
import 'package:ecommerce_app/widget/card_invoice.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class InvoicePage extends StatefulWidget {
  const InvoicePage({Key key}) : super(key: key);

  @override
  State<InvoicePage> createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage> {
  List<InvoiceModel> list = [];
  List<InvoiceModel> listDone = [];
  getInvoice() async {
    list.clear();
    var urlHistory = Uri.parse(BASEURL.getInvoice);
    final response = await http.get(urlHistory);
    if (response.statusCode == 200) {
      setState(() {
        list = invoiceModelFromJson(response.body)
            .where((element) => element.status == '1')
            .toList();
        listDone = invoiceModelFromJson(response.body)
            .where((element) => element.status == '2')
            .toList();
      });
    }
  }

  Future updateStatus(String idOrder) async {
    setState(() {
      getInvoice();
    });
  }

  @override
  void initState() {
    super.initState();
    getInvoice();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.amber[500],
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.pending_actions)),
                Tab(icon: Icon(Icons.paid)),
              ],
            ),
            title: const Text('Daftar Invoice'),
          ),
          body: TabBarView(
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: list.length,
                itemBuilder: (context, i) {
                  final x = list[i];
                  return Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                    child: CardInvoice(
                      model: x,
                      onPressed: updateStatus,
                    ),
                  );
                },
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: listDone.length,
                itemBuilder: (context, i) {
                  final x = listDone[i];
                  return Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                    child: CardInvoice(
                      model: x,
                      onPressed: updateStatus,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
