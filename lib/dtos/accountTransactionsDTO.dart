import '../models/accountTransaction.dart';

class AccountTransactionsDTO {
  List<AccountTransaction> accountTransactions;

  AccountTransactionsDTO({this.accountTransactions});

  factory AccountTransactionsDTO.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['results'] as List;
    List<AccountTransaction> transactionList = list.map((i) => AccountTransaction.fromJson(i)).toList();
    return AccountTransactionsDTO(accountTransactions: transactionList);
  }
}
