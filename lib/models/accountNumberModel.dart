class AccountNumber {

  String iban; //	ISO 13616-1:2007 international bank number
  String number; //	Bank account number
  String sort_code; //	United Kingdom SORT code
  String swift_bic; //	ISO 9362:2009 Business Identifier Codes


  AccountNumber(
      {this.iban,
        this.number,
        this.sort_code,
        this.swift_bic
      });

  factory AccountNumber.fromJson(Map<String, dynamic> parsedJson) {
    return AccountNumber(
        iban: parsedJson['iban'],
        number: parsedJson['number'],
        sort_code: parsedJson['sort_code'],
        swift_bic: parsedJson['swift_bic']);
  }
}