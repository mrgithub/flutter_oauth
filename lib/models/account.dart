import 'accountNumber.dart';
import 'provider.dart';

class Account {
  String account_id; //	Unique identifier of the account
  String account_type; //	Type of the account[j]
  String currency; //	ISO 4217 alpha-3 currency code of the account
  String display_name; //	Human readable name of the account
  String update_timestamp; //	Last update time of the account
  AccountNumber accountNumber;
  Provider provider;

  Account(
      {this.account_id,
      this.account_type,
      this.currency,
      this.display_name,
      this.update_timestamp,
      this.accountNumber,
      this.provider});

  factory Account.fromJson(Map<String, dynamic> parsedJson) {
    return Account(
        account_id: parsedJson['account_id'],
        account_type: parsedJson['account_type'],
        currency: parsedJson['currency'],
        display_name: parsedJson['display_name'],
        update_timestamp: parsedJson['update_timestamp'],
        accountNumber: AccountNumber.fromJson(parsedJson['account_number']),
        provider: Provider.fromJson(parsedJson['provider']));
  }
}
