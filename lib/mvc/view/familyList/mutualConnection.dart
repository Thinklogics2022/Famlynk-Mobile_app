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
  List<FamListModel> familyLists = [];
  MutualService mutualService = MutualService();

  var isLoaded = false;
  @override
  void initState() {
    super.initState();
    fetchFamilyMembers(widget.uniqueUserId.toString());
  }

  Future<void> fetchFamilyMembers(String uniqueUserId) async {
    if (familyLists.isEmpty) {
      try {
        familyLists = await mutualService.mutualService(uniqueUserId);

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
          ? familyLists.isEmpty
              ? Center(child: Text("No more mutual connections"))
              : GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 1,
                  ),
                  itemCount: familyLists.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: Column(
                            children: [
                              SizedBox(height: 10),
                              CircleAvatar(
                                radius: 45,
                                backgroundImage: NetworkImage(
                                    familyLists[index].image.toString()),
                              ),
                              SizedBox(height: 10),
                              Text(
                                familyLists[index].name.toString(),
                                style: TextStyle(
                                    fontSize: 20,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(familyLists[index].relation.toString()),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
