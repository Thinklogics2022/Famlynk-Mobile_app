import 'package:famlynk_version1/services/familySevice/mutualService.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../model/familyMembers/famlist_modelss.dart';

class MutualConnection extends StatefulWidget {
  const MutualConnection({super.key, required this.uniqueUserId});
  final String uniqueUserId;
  @override
  State<MutualConnection> createState() => _MutualConnectionState();
}

class _MutualConnectionState extends State<MutualConnection> {
  List<FamListModel> familyList = [];
  MutualService mutualService = MutualService();

  var isLoaded = true;
  @override
  void initState() {
    super.initState();
    fetchFamilyMembers(widget.uniqueUserId.toString());
  }

  Future<void> fetchFamilyMembers(String uniqueUserId) async {
    if (familyList.isEmpty) {
      try {
        familyList = await mutualService.mutualService(uniqueUserId);

        setState(() {
          isLoaded = false;
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
                ?  Center(
                child: CircularProgressIndicator()
              )
                :
                 ListView.builder(
                    itemCount: familyList.length,
                    itemBuilder: (context, index) {
                      return InkWell(child: Card(
                        child: Column(
                          children: [
                            Text(familyList[index].name.toString())
                          ],
                        ),
                      ));
                    })
            : Center(
                child: Text("No more mutual connection"),
              )
              );
  }
}
