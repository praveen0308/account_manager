class WalletModel {
  int walletId;
  String name;
  double credit;
  double debit;

  WalletModel(this.walletId, this.name, this.credit, this.debit);

  @override
  String toString() {
    return name;
  }
}
