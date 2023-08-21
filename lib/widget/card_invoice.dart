import 'package:ecommerce_app/network/model/invoice_model.dart';
import 'package:ecommerce_app/theme.dart';
import 'package:flutter/material.dart';

class CardInvoice extends StatelessWidget {
  final InvoiceModel model;
  final Future Function(String) onPressed;

  const CardInvoice({Key key, this.model, this.onPressed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(model.invoice, style: boldTextStyle.copyWith(fontSize: 16)),
            const Icon(
              Icons.arrow_forward_ios,
              size: 14,
            )
          ],
        ),
        const SizedBox(
          height: 6,
        ),
        Text(
          model.fullname,
          style: regulerTextStyle.copyWith(fontSize: 16),
        ),
        const SizedBox(
          height: 6,
        ),
        if (model.status == '1')
          ElevatedButton(
            onPressed: () async {
              await onPressed(model.idOrders);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: const Text('Update Sukses'),
                  backgroundColor: Colors.amber[500]));
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.amber[500],
            ),
            child: const Text(
              'Sudah Bayar',
            ),
          ),
        const Divider()
      ],
    );
  }
}
