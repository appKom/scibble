class Token {
  final String? accessToken;
  final String? refreshToken;
  final String? tokenType;
  final DateTime? expiresAt;
  final String? idToken;

  bool? get isExpired =>
      expiresAt != null ? new DateTime.now().isAfter(expiresAt!) : null;
  String? get accesstoken => accessToken;

  Token({
    this.accessToken,
    this.refreshToken,
    this.tokenType,
    this.expiresAt,
    this.idToken,
  });

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
      tokenType: json['token_type'],
      expiresAt: json['expires_in'] != null
          ? new DateTime.now().add(new Duration(seconds: json['expires_in']))
          : null,
      idToken: json['id_token'],
    );
  }

  Map<String, dynamic> toJson() => {
        'access_token': accessToken,
        'refresh_token': refreshToken,
        'token_type': tokenType,
        'expires_in': expiresAt?.millisecondsSinceEpoch,
        'id_token': idToken,
      };
}
