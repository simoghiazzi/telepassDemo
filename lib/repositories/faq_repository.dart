class FaqRepository {
  Future<Map<String, dynamic>> getFaqs(String token) async {
    ///Example of what could be done for an actual API call, via the Dio package, getting session tokens and then potentially using them for retrieving user's data
    // try {
    //    Response response = await dio.get(
    //     '$baseUrl/faqs',
    //     options: Options(
    //       headers: {
    //         'authorization': 'Bearer $token',
    //       },
    //     ),
    //   );

    //   if (response.statusCode == 200) {
    //     final data = response.data as Map<String, dynamic>;
    //     return data;
    //   } else {
    //     throw Exception('Failed getting faqs: ${response.data}');
    //   }
    // } on DioException catch (e) {
    //   if (e.response != null && e.response?.data != null) {
    //     throw Exception('Error getting faqs: ${e.response?.data}');
    //   } else {
    //     throw Exception('Error sending request: ${e.message}');
    //   }
    // }

    //Mocking awaiting for the API response
    await Future.delayed(const Duration(seconds: 1));

    return {
      "faqs": [
        {
          "question": "Come ottenere punti?",
          "answer":
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu turpis molestie, dictum est a, mattis tellus. Sed dignissim, metus nec fringilla accumsan, risus sem sollicitudin lacus, ut interdum tellus elit sed risus. Maecenas eget condimentum velit, sit amet feugiat lectus. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.",
        },
        {
          "question": "Come ottenere badge?",
          "answer":
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu turpis molestie, dictum est a, mattis tellus. Sed dignissim, metus nec fringilla accumsan, risus sem sollicitudin lacus, ut interdum tellus elit sed risus. Maecenas eget condimentum velit, sit amet feugiat lectus. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.",
        },
        {
          "question": "Come cambiare password?",
          "answer":
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu turpis molestie, dictum est a, mattis tellus. Sed dignissim, metus nec fringilla accumsan, risus sem sollicitudin lacus, ut interdum tellus elit sed risus. Maecenas eget condimentum velit, sit amet feugiat lectus. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.",
        },
      ],
    };
  }
}
