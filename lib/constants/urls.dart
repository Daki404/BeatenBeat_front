class Url {
  Url._();
  static const String loginOAuthUrl = 'http://localhost:8080/api/v1/login';
  static const String kakaoOAuthUrl = loginOAuthUrl + '/kakao';
  static const String naverOAuthUrl = loginOAuthUrl + '/naver';
  static const String googleOAuthUrl = loginOAuthUrl + '/google';
}
