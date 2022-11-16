import 'package:account_manager/models/currency.dart';
import 'package:account_manager/res/text_styles.dart';
import 'package:account_manager/utils/share_utils.dart';
import 'package:flutter/material.dart';

class TransactionFullDetailDialog extends StatefulWidget {
  final String title;
  final Map<int, int> notes;
  final double mAdded;
  final double mSubtracted;
  final String? remark;

  const TransactionFullDetailDialog(
      {Key? key,
      required this.title,
      required this.notes,
      required this.mAdded,
      required this.mSubtracted,
      this.remark})
      : super(key: key);

  @override
  State<TransactionFullDetailDialog> createState() =>
      _TransactionFullDetailDialogState();
}

class _TransactionFullDetailDialogState
    extends State<TransactionFullDetailDialog> {
  List<Currency> currencies = [];
  double denominationTotal = 0;
  double grandTotal = 0;
  String msg = "";

  @override
  void initState() {
    currencies.clear();
    currencies = widget.notes.entries
        .map((e) => Currency(item: e.key, qty: e.value))
        .toList();

    for (var element in currencies) {
      denominationTotal += element.item * element.qty!;
      msg += "${element.item} x ${element.qty} = ${element.item * element.qty!}\n";
    }
    msg+="Denomination Total : $denominationTotal\n";
    msg+="M. Added : ${widget.mAdded}\n";
    msg+="M. Subtracted : ${widget.mSubtracted}\n";
    msg+="Grand Total :$grandTotal\n";
    if(widget.remark!=null){
      msg+="Remark : ${widget.remark}\n";
    }


    grandTotal = denominationTotal + widget.mAdded - widget.mSubtracted;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: DefaultTextStyle(
        style: const TextStyle(fontSize: 16, color: Colors.black),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    padding: const EdgeInsets.all(0),
                    constraints: const BoxConstraints(),
                    onPressed: () {
                      ShareUtil.launchWhatsapp(msg);
                    },
                    icon: const Icon(Icons.share)),
                IconButton(
                    padding: const EdgeInsets.all(0),
                    constraints: const BoxConstraints(),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close)),
              ],
            ),
            Text(
              widget.title,
              style: Theme.of(context).textTheme.headline4,
            ),
            const SizedBox(
              height: 32,
            ),
            ListView.separated(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (_, index) {
                var currency = currencies[index];
                return Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(currency.item.toString()),
                      const Text("x"),
                      Text(currency.qty.toString()),
                      Text((currency.item * currency.qty!).toString())
                    ],
                  ),
                );
              },
              itemCount: widget.notes.length,
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(
                  thickness: 1,
                );
              },
            ),
            const Divider(
              thickness: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Denomination Total :"),
                Text("₹$denominationTotal")
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Manually Added :"),
                Text("+₹${widget.mAdded}")
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Manually Subtracted :"),
                Text("-₹${widget.mSubtracted}")
              ],
            ),
            const Divider(
              thickness: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [const Text("Grand Total :",style: TextStyle(fontWeight: FontWeight.w700),), Text("₹$grandTotal",style: const TextStyle(fontWeight: FontWeight.w700),)],
            ),

            Visibility(
              visible: widget.remark!=null,
              child: Row(

                children: [const Text("Remark : ",style: TextStyle(fontWeight: FontWeight.w700,color: Colors.red),), Text(widget.remark??"",style: const TextStyle(color: Colors.red),)],
              ),
            ),
            const SizedBox(height: 32,),


          ],
        ),
      ),
    );
  }
}
