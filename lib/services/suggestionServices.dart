import 'package:famlynk_version1/mvc/model/suggestionModel.dart';
import 'package:famlynk_version1/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SuggestionService {
  Future<List<Suggestion>> getSuggestions() async {
    try {
      final response = await http.get(Uri.parse(FamlynkServiceUrl.allUser));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        if (jsonData is List) {
          List<Suggestion> suggestions = jsonData
              .map((json) => Suggestion.fromJson(json))
              .toList();
          return suggestions;
        } else {
          throw Exception('Invalid response format: expected a JSON array');
        }
      } else {
        throw Exception('Failed to fetch data from the backend');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server: $e');
    }
  }
}
