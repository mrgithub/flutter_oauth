import '../models/accountBalance.dart';

class AccountBalanceDTO {
  
  AccountBalance accountBalance;
  String status;

  AccountBalanceDTO({
    this.accountBalance,
    this.status});

  factory AccountBalanceDTO.fromJson(Map<String, dynamic> parsedJson) {


    var list = parsedJson['results'] as List;
    //print(list.runtimeType);
    List<AccountBalance> balanceList = list.map((i) => AccountBalance.fromJson(i)).toList();

    return AccountBalanceDTO(
        accountBalance: balanceList.first,
        status: parsedJson['status']);
  }
}