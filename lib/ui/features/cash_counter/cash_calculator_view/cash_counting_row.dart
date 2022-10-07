import 'dart:math';

import 'package:account_manager/res/app_colors.dart';
import 'package:account_manager/utils/toaster.dart';
import 'package:flutter/material.dart';

class CashCountingRow extends StatefulWidget {
  final int item;
  final int qty;
  final Function(int item,int qty) onQtyChanged;

  const CashCountingRow(
      {Key? key, required this.item, required this.qty, required this.onQtyChanged})
      : super(key: key);

  @override
  State<CashCountingRow> createState() => _CashCountingRowState();
}

class _CashCountingRowState extends State<CashCountingRow> {
  int qty = 0;
  int total =0;
  final txtController = TextEditingController();

  @override
  void initState() {
    qty = widget.qty;
    total = getTotal(widget.item, qty);
    if(qty==0){
      txtController.text = "";
    }else{
      txtController.text = qty.toString();
    }


    txtController.addListener(() {

      if(txtController.text.isNotEmpty){
        qty = int.parse(txtController.text);
      }else{
        qty = 0;
      }
      widget.onQtyChanged(widget.item,qty);
      setState((){
        total = getTotal(widget.item,qty);
        // txtController.text = qty.toString();

      });

    });
    super.initState();

  }



  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(widget.item.toString(),style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
        const Text("x"),
        Container(
          decoration: BoxDecoration(
              color: AppColors.primaryLightest,
              border: Border.all(color: AppColors.primaryDarkest),
          borderRadius: BorderRadius.circular(4)),

          child: SizedBox(
            width: 70,
            height: 30,
            child: TextFormField(

              // onFieldSubmitted: quantityChanged,
              cursorHeight: 0,
              cursorWidth: 0,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              maxLines: 1,
              maxLength: 4,

              decoration: const InputDecoration(
                hintText: "0",
                counterText: "",
                border: InputBorder.none,

              ),
              controller: txtController,
            ),
          ),
        ),
        const Text("="),
        Text(total.toString(),style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w500),)
      ],
    );
  }
  int getTotal(int item,int qty){
    return item * qty;
  }
}
