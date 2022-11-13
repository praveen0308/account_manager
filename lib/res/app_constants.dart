
import 'package:account_manager/models/wallet_model.dart';

class AppConstants{
  static List<WalletModel> getWallets(){
    List<WalletModel> wallets = [];
    wallets.add(WalletModel(1, "Business 1", 0, 0));
    wallets.add(WalletModel(2, "Business 2", 0, 0));
    wallets.add(WalletModel(3, "Business 3", 0, 0));

    return wallets;
  }
}