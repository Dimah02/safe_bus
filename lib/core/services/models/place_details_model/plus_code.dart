class PlusCode {
  String? globalCode;
  String? compoundCode;

  PlusCode({this.globalCode, this.compoundCode});

  factory PlusCode.fromJson(Map<String, dynamic> json) {
    return PlusCode(
      globalCode: json['globalCode'] as String?,
      compoundCode: json['compoundCode'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'globalCode': globalCode, 'compoundCode': compoundCode};
  }
}
