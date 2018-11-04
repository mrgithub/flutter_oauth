import '../models/account.dart';

class AccountsDTO {
  List<Account> accounts;

  AccountsDTO({this.accounts});

  factory AccountsDTO.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['results'] as List;
    List<Account> accountList = list.map((i) => Account.fromJson(i)).toList();
    return AccountsDTO(accounts: accountList);
  }
}
