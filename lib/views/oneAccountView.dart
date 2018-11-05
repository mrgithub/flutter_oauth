import 'package:flutter/material.dart';
import '../models/accountTransactionModel.dart';

class OneAccountScreen extends StatelessWidget {

  final List<AccountTransaction> transactions;

  // In the constructor, requires the accounts DTO
  OneAccountScreen({Key key, @required this.transactions}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var items = transactions;

    return Scaffold(
      appBar: AppBar(
        title: Text ("Transactions"),
      ),
      body: ListView.builder(
        itemCount: transactions.length,

        itemBuilder: (context, index) {

          return ListTile(
//            leading: transactions[index].transaction_type == "DEBIT" ? const Icon(Icons.account_balance) : const Icon(Icons.account_balance_wallet),
//            subtitle: Text(transactions[index].description ),
//            title: Text(transactions[index].merchant_name + " " + transactions[index].amount.toString()),

            //leading: items[index].transaction_type == "DEBIT" ? const Icon(Icons.account_balance) : const Icon(Icons.account_balance_wallet),
            title: Text(items[index].description),
            subtitle: Text(items[index].amount.toString()),

            onTap: ()  {

              //_getTransactions(account);
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

}