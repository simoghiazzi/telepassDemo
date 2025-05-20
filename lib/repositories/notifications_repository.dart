class NotificationsRepository {
  Future<Map<String, dynamic>> getNotifications(String token) async {
    ///Example of what could be done for an actual API call, via Dio package, getting notifications

    // try {
    //    Response response = await dio.get(
    //     '$baseUrl/notifications/unread',
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
    //     throw Exception('Failed getting notifications: ${response.data}');
    //   }
    // } on DioException catch (e) {
    //   if (e.response != null && e.response?.data != null) {
    //     throw Exception('Error getting notifications: ${e.response?.data}');
    //   } else {
    //     throw Exception('Error sending request: ${e.message}');
    //   }
    // }

    //Mocking awaiting for the API response
    await Future.delayed(const Duration(seconds: 1));

    // we simulate that the first two notifications are today, the last three are this week
    final now = DateTime.now();
    final threeDaysAgo = now.subtract(const Duration(days: 3));

    return {
      "notifications": [
        {
          "title": "CORSO IN SCADENZA",
          "body": "Progettazione e sviluppo di sistemi di pedaggio elettronico",
          "createdAt": now.toIso8601String(),
          "category": "expiring",
        },
        {
          "title": "BADGE IN ARRIVO",
          "body": "Complimenti, hai completato 25 corsi!",
          "createdAt": now.toIso8601String(),
          "category": "achievement",
        },
        {
          "title": "NUOVO CORSO CARICATO",
          "body": "Progettazione e sviluppo di sistemi di pedaggio elettronico",
          "createdAt": threeDaysAgo.toIso8601String(),
          "category": "update",
        },
        {
          "title": "NUOVO DOCUMENTO CARICATO",
          "body": "Come modificare la targa associata al dispositivo Telepass",
          "createdAt": threeDaysAgo.toIso8601String(),
          "category": "update",
        },
        {
          "title": "CORSO IN SCADENZA",
          "body": "Progettazione e sviluppo di sistemi di pedaggio elettronico",
          "createdAt": threeDaysAgo.toIso8601String(),
          "category": "expiring",
        },
      ],
    };
  }
}
