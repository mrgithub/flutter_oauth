class AccountBalance {
  double available; //	Available balance, including pre-arranged overdraft limit
  String currency; //	ISO 4217 alpha-3 currency code
  double current; //	Current balance
  double
  overdraft; //	Pre-arranged overdraft limit. Available for all "TRANSACTION” and “BUSINESS_TRANSACTION” account types. See Account Types
  String update_timestamp; // datetime	Last update time

  AccountBalance(
      {this.available,
        this.currency,
        this.current,
        this.overdraft,
        this.update_timestamp});

  factory AccountBalance.fromJson(Map<String, dynamic> parsedJson) {
    return AccountBalance(
        available: parsedJson['available'],
        currency: parsedJson['currency'],
        current: parsedJson['current'],
        overdraft: parsedJson['overdraft'],
        update_timestamp: parsedJson['update_timestamp']);
  }
}