class OAuthApi {
  OAuthApi._();
  static const String host = 'http://localhost';
  static const String loginOAuthUrl = '/api/v1/login';

  static const String kakaoOAuthUrl = loginOAuthUrl + '/kakao';
  static const String naverOAuthUrl = loginOAuthUrl + '/naver';
  static const String googleOAuthUrl = loginOAuthUrl + '/google';
}
