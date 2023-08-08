import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../services/familySevice/famDetailService.dart';
import '../../../services/familySevice/individulaUserService.dart';
import '../../model/familyMembers/famlist_modelss.dart';

class Family extends StatefulWidget {
  const Family({super.key, required this.userId});
  final String userId;
  @override
  State<Family> createState() => _FamilyState();
}

class _FamilyState extends State<Family> {
  var isLoaded = false;
  FamListModel famListModel = FamListModel();
  List<FamListModel> familyList = [];

  IndividulaUserService individulaUserService = IndividulaUserService();

  @override
  void initState() {
    super.initState();
    fetchAPI();
  }

  Future<void> fetchAPI() async {
    if (familyList.isEmpty) {
      try {
        familyList = await individulaUserService.familyService(widget.userId);
 if (familyList.isNotEmpty) {
          familyList = familyList.sublist(1);
        }
        setState(() {
          isLoaded = true;
        });
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoaded
          ? familyList.isEmpty
              ? Center(child: Text("There is no list to show"))
              : ListView.builder(
                  itemCount: familyList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                        child: Card(
                            child: Container(
                                margin: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  color: Color.fromARGB(255, 221, 232, 232),
                                ),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: CircleAvatar(
                                          radius: 35,
                                          backgroundImage: NetworkImage(
                                              familyList[index]
                                                  .image
                                                  .toString()),
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            familyList[index].name.toString(),
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(familyList[index]
                                              .relation
                                              .toString()),
                                        ],
                                      ),
                                    ]))));
                  })
          : Center(
              child: CircularProgressIndicator(),
            ),

    
    );
  }
}
































// // import 'package:famlynk_version1/mvc/model/familyMembers/famlist_modelss.dart';
// // import 'package:flutter/material.dart';


// // class About extends StatefulWidget {
// //   const About({super.key, required this.details});
// //   final FamListModel details;

// //   @override
// //   State<About> createState() => _AboutState();
// // }

// // class _AboutState extends State<About> {
// //   var isLoaded = false;

// //   FamListModel famListModel = FamListModel();
// //   bool isLoading = true;

// //   @override
// //   void initState() {
// //     super.initState();
// //     // fetchAPI();
// //   }

 
// // // fetchAPI() async {
// // //     try {
// // //       famListModel = await famDetailsService.famDetails();
// // //       setState(() {
// // //         isLoading = false;
// // //       });
// // //     } catch (e) {
// // //       print(e);
// // //     }
// // //   }
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: Container(
// //         child: Column(
// //           children: [Text(
// //           widget.details.dob.toString()
// //           )],
// //         ),
// //       ),
// //     );
// //   }
// // }
