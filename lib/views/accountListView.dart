import '../dtos/accountsDTO.dart';
import 'package:flutter/material.dart';
import 'oneAccountView.dart';
import '../dtos/accountTransactionsDTO.dart';
import '../helpers/credentialsHelper.dart';
import 'package:http/http.dart' as http;
import '../models/accountTransactionModel.dart';
import 'dart:convert';

class AccountListScreen extends StatelessWidget {

  final AccountsDTO accountsDTO;

  // In the constructor, requires the accounts DTO
  AccountListScreen({Key key, @required this.accountsDTO}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var accounts = accountsDTO.accounts;

    return Scaffold(
      appBar: AppBar(
        title: Text('AccountListScreen'),
      ),
      body: ListView.builder(
        itemCount: accounts.length,
        itemBuilder: (context, index) {

          var item = accounts[index];

          return ListTile(
            leading: item.account_type == "TRANSACTION" ? const Icon(Icons.account_balance) : const Icon(Icons.account_balance_wallet),
            title: Text(item.accountNumber.sort_code + " " + item.accountNumber.number),
            subtitle: Text(item.account_id),

            onTap: () async {

              var list = await getTrans(item.account_id);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OneAccountScreen(transactions : list),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<List<AccountTransaction>> getTrans(String _accountId) async {

    // https://api.truelayer.com/data/v1/accounts/${account_id}/transactions?from=${from}&to=${to}
    var getAccountTransactionsUri = "https://api.truelayer.com/data/v1/accounts/${_accountId}/transactions";

    var x = new Credentials().getToken;

    final response = await http.get(
      getAccountTransactionsUri,
      headers: {
        'authorization': 'bearer $x',
        'content-type': 'application/json'
      },
    );

    //print("transactions ********************* " + response.body);

    var transactionsDTO = AccountTransactionsDTO.fromJson(jsonDecode(response.body));

    return transactionsDTO.accountTransactions;
  }
}
