import '../dtos/accountsDTO.dart';
import 'package:flutter/material.dart';
import 'oneAccountView.dart';

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

            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OneAccountScreen(account : item),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
