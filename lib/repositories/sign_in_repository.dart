class SigninRepository {
  Future<Map<String, dynamic>> signin(Map<String, String> authData) async {
    ///Example of what could be done for an actual API call, via the Dio package, getting session tokens and then potentially using them for retrieving user's data
    // try {
    //   final Map<String, dynamic> data = {
    //     'email': authData['email'],
    //     'password': authData['password'],
    //   };
    //   Response response = await dio.post(
    //     '$baseUrl/auth/sign-in',
    //     data: data,
    //   );

    //   if (response.statusCode == 200) {
    //     final data = response.data as Map<String, dynamic>;
    //     final token = data['token'];
    //     final token = data['token'];
    //     return {'token': token, 'token': token};
    //   } else {
    //     throw Exception('Login failed: ${response.data}');
    //   }
    // } on DioException catch (e) {
    //   if (e.response != null && e.response?.data != null) {
    //     if (e.response?.statusCode == 403) {
    //       throw "Verifica di aver confermato la tua email";
    //     } else {
    //       throw "Username o password errati, riprovare";
    //     }
    //   } else {
    //     throw Exception('Error sending request: ${e.message}');
    //   }
    // }

    //Mocking awaiting for the API response
    await Future.delayed(const Duration(seconds: 2));
    // Simulated user JSON
    return {
      'id': 1,
      'createdAt': '2025-05-18T22:00:00Z',
      'updatedAt': null,
      'deletedAt': null,
      'email': authData['email'],
      'username': 'testuser',
      'age': 28,
      'token': 'dummy_refresh_token',
      'tokenExpDate': '2025-06-18T22:00:00Z',
      'personalData': {
        'id': 100,
        'createdAt': '2025-05-18T22:00:00Z',
        'updatedAt': null,
        'deletedAt': null,
        'lastName': 'Rossi',
        'firstName': 'Mario',
        'birthDate': '1997-01-01',
        'gender': 'M',
      },
    };
  }
}
