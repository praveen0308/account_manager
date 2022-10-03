import 'package:account_manager/models/wallet_model.dart';
import 'package:account_manager/res/app_colors.dart';
import 'package:flutter/material.dart';

class WalletView extends StatelessWidget {
  final WalletModel walletModel;
  final Color color;

  const WalletView({Key? key, required this.walletModel, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4), color: AppColors.white),
            height: 36,
            width: 36,
            child: Center(
              child: Text(
                walletModel.walletId.toString(),
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "+₹${walletModel.credit}",
                  style: const TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 15),
                ),
                Text("-₹${walletModel.debit}",
                    style: const TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 15)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
