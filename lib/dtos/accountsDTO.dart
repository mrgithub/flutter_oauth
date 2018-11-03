import '../models/account.dart';

class AccountsDTO {
  List<Account> accounts;
  // String status;

  AccountsDTO({this.accounts}); //, this.status});

  factory AccountsDTO.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['results'] as List;
    //print(list.runtimeType);
    List<Account> accountList = list.map((i) => Account.fromJson(i)).toList();

    return AccountsDTO(accounts: accountList);  //, status: parsedJson['status']);
  }
}
