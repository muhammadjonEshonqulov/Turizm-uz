

abstract class NetworkUtils {
  const NetworkUtils();

// static Future<void> renewToken(Response response) async {
//   if (response.headers['authorization'] != null) {
//     debugPrint('EXPIRED... RENEWING');
//     var token = response.headers['authorization'] as String;
//     debugPrint('TOKEN: $token');
//     if (token.startsWith('Bearer')) {
//       token = token.replaceFirst('Bearer', '').trim();
//     }
//     await sl<CacheHelper>().cacheSessionToken(token);
//   }
// }
}
