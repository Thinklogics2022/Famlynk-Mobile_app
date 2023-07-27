import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:famlynk_version1/mvc/model/suggestion_model.dart';
import 'package:famlynk_version1/mvc/view/suggestion/personal_detials.dart';
import 'package:famlynk_version1/services/suggestion_services.dart';
import 'package:famlynk_version1/utils/utils.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SuggestionScreen extends StatefulWidget {
  const SuggestionScreen({super.key});

  @override
  State<SuggestionScreen> createState() => _SuggestionScreenState();
}

class _SuggestionScreenState extends State<SuggestionScreen> {
  List<Suggestion> suggestionlist = [];
  bool isLoaded = false;
  String currentQuery = '';
  List<Suggestion> filteredSuggestions = [];
  int pageNumber = 0;
  int pageSize = 20;
  String userId = '';
  int registerMember = 0;

  Future<void> fetchData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('userId') ?? '';
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
    // fetchTotalRegisterMembers();
    fetchSuggestions();
  }

  // Future<void> fetchTotalRegisterMembers() async {
  //   try {
  //     final response = await http.get(
  //       Uri.parse('${FamlynkServiceUrl.searchAllUser}$userId'),
  //     );
  //     if (response.statusCode == 200) {
  //       final registerMemberTotal = json.decode(response.body);
  //       if (registerMemberTotal < 0 && registerMemberTotal >= pageSize) {
  //         setState(() {
  //           registerMember = 0;
  //         });
  //       } else {
  //         setState(() {
  //           registerMember = (registerMemberTotal / pageSize).ceil();
  //         });
  //       }
  //     } else {
  //       print('Failed to fetch total register members. Status code: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     print('Error: $e');
  //   }
  // }

  Future<void> fetchSuggestions() async {
    SuggestionService suggestionService = SuggestionService();
    try {
      var newSuggestions =
          await suggestionService.getAllSuggestions();

      setState(() {
        suggestionlist.addAll(newSuggestions);
        isLoaded = true;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  void loadMoreSuggestions() {
    pageNumber++;
    fetchSuggestions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 223, 228, 237),
      appBar: AppBar(
        backgroundColor: HexColor('#0175C8'),
        title: Text(
          'Suggestions',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: TypeAheadFormField(
              textFieldConfiguration: TextFieldConfiguration(
                onChanged: (value) {
                  setState(() {
                    currentQuery = value;
                    filteredSuggestions = suggestionlist
                        .where((suggestion) =>
                            suggestion.name
                                .toString()
                                .toLowerCase()
                                .contains(value.toLowerCase()))
                        .toList();
                  });
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                  hintText: "Search",
                  suffixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(),
                  ),
                ),
              ),
              suggestionsCallback: (pattern) async {
                return suggestionlist
                    .where((suggestion) =>
                        suggestion.name.toString().toLowerCase().contains(pattern.toLowerCase()))
                    .toList();
              },
              itemBuilder: (context, suggestion) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage("assets/images/apple.png"),
                    backgroundColor: Colors.transparent,
                  ),
                  title: Text(suggestion.name.toString()),
                );
              },
              onSuggestionSelected: (suggestion) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserDetails(
                      name: suggestion.name.toString(),
                      gender: suggestion.gender.toString(),
                      address: suggestion.address.toString(),
                      dateOfBirth: suggestion.dateOfBirth.toString(),
                      email: suggestion.email.toString(),
                      hometown: suggestion.hometown.toString(),
                      maritalStatus: suggestion.maritalStatus.toString(),
                      // profileImage: suggestion.profileImage.toString(),
                      uniqueUserID: suggestion.uniqueUserID.toString(),
                      mobileNo: suggestion.mobileNo.toString(),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: currentQuery.isEmpty ? suggestionlist.length : filteredSuggestions.length,
              itemBuilder: (context, index) {
                final suggestion = currentQuery.isEmpty ? suggestionlist[index] : filteredSuggestions[index];
                if (index == suggestionlist.length - 1 && currentQuery.isEmpty) {
                  loadMoreSuggestions();
                }

                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserDetails(
                          name: suggestion.name.toString(),
                          gender: suggestion.gender.toString(),
                          address: suggestion.address.toString(),
                          dateOfBirth: suggestion.dateOfBirth.toString(),
                          email: suggestion.email.toString(),
                          hometown: suggestion.hometown.toString(),
                          maritalStatus: suggestion.maritalStatus.toString(),
                          // profileImage: suggestion.profileImage.toString(),
                          uniqueUserID: suggestion.uniqueUserID.toString(),
                          mobileNo: suggestion.mobileNo.toString(),
                        ),
                      ),
                    );
                  },
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage("assets/images/apple.png"),
                      backgroundColor: Colors.transparent,
                    ),
                    title: Text(suggestion.name.toString()),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
