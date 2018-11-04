import '../models/accountModel.dart';
import 'package:flutter/material.dart';
import '../helpers/credentialsHelper.dart';
import 'package:http/http.dart' as http;

class OneAccountScreen extends StatelessWidget {

  final Account account;

  // In the constructor, requires the accounts DTO
  OneAccountScreen({Key key, @required this.account}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(account.accountNumber.sort_code + " " + account.accountNumber.number),
      ),
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {

          var item = account;

          return ListTile(
            leading: item.account_type == "TRANSACTION" ? const Icon(Icons.account_balance) : const Icon(Icons.account_balance_wallet),

            title: Text(item.accountNumber.sort_code + " " + item.accountNumber.number),
            subtitle: Text(item.account_id),

            onTap: () { _getTransactions();
//              Navigator.push(
//                context,
//                MaterialPageRoute(
//                  builder: (context) => AccountListScreen(todo: todos[index]),
//                ),
//              );
            },
          );
        },
      ),
    );
  }

  _getTransactions() async {
//    accessToken = await getToken();
//    txt.text = DateTime.now().second.toString() + ": " + accessToken.getAccess;
    const String oneAccountId = "56c7b029e0f8ec5a2334fb0ffc2fface";

    // https://api.truelayer.com/data/v1/accounts/${account_id}/transactions?from=${from}&to=${to}
    const getAccountTransactionsUri = "https://api.truelayer.com/data/v1/accounts/${oneAccountId}";

    var x = new Credentials().getToken;

    final response = await http.get(
      getAccountTransactionsUri,
      headers: {
        'authorization': 'bearer $x',
        'content-type': 'application/json'
      },
    );

    //txt.text = DateTime.now().second.toString() + ": Account: ";

    print("transactions ********************* " + response.body);

  }

}