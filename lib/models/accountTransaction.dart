
class AccountTransaction {
  String transaction_id; //	Unique identifier of the transaction
  String timestamp; //	Date the transaction was posted on the account
  String
      description; //	Original description of the transaction as reported by the Provider
  String transaction_type; //	Type of the transaction
  String transaction_category; //	Category of the transaction
  String merchant_name; //	Name of the merchant
  double amount; //	Amount of the transaction
  String currency; //	ISO 4217 alpha-3 currency code
  //TransactionClassification transaction_classification	array	Classification of the transaction
  //meta	object	OPTIONAL. A collection of additional Provider specific transaction metadata

  AccountTransaction(
      {this.transaction_id,
      this.timestamp,
      this.description,
      this.transaction_type,
      this.transaction_category,
      this.merchant_name,
      this.amount,
      this.currency});

  factory AccountTransaction.fromJson(Map<String, dynamic> parsedJson) {
    return AccountTransaction(
      transaction_id: parsedJson['transaction_id'],
      timestamp: parsedJson['timestamp'],
      description: parsedJson['description'],
      transaction_type: parsedJson['transaction_type'],
      transaction_category: parsedJson['transaction_category'],
      merchant_name: parsedJson['merchant_name'],
      amount: parsedJson['amount'],
      currency: parsedJson['currency'],
      //accountNumber: AccountNumber.fromJson(parsedJson['account_number']),
      //provider: Provider.fromJson(parsedJson['provider'])
    );
  }
}
