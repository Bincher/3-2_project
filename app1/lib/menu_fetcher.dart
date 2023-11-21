// menu_fetcher.dart

import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'package:intl/intl.dart';

class MenuFetcher {
  static Future<Map<String, dynamic>> fetchMenuData(DateTime selectedDate) async {
    try {
      final response = await http.get(
        Uri.parse('https://www.kumoh.ac.kr/ko/restaurant04.do?mode=menuList&srDt=${DateFormat('yyyy').format(selectedDate)}-${DateFormat('MM').format(selectedDate)}-${DateFormat('dd').format(selectedDate)}'),
        headers: {
          'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/112.0.0.0 Safari/537.36',
        },
      );

      if (response.statusCode == 200) {
        final document = parse(response.body);
        final foodElements = document.querySelectorAll(".menu-list-box table tbody tr:nth-child(1) td:nth-child(${selectedDate.weekday * 2 - 1})");

        if (foodElements.isNotEmpty) {
          final foodMenu = foodElements[0].text;
          final modifiedFoodMenu = foodMenu.replaceAll(RegExp(r'\s{2,}'), '\n');
          List<String> foodMenuLines = modifiedFoodMenu.split('\n');
          foodMenuLines.removeWhere((element) => element.trim().isEmpty);

          Map<String, dynamic> jsonData = {
            'menuLines': foodMenuLines,
            'selectedDate': DateFormat('MM-dd').format(selectedDate),
            'selectedLocation': "snack",
            'time': "."
          };
          return jsonData;
        } else {
          return {'error': '데이터가 존재하지 않습니다.'};
        }
      } else {
        return {'error': '데이터를 가져오는 중 오류가 발생했습니다. Response code: ${response.statusCode}'};
      }
    } catch (e) {
      return {'error': '오류: $e'};
    }
  }
}
