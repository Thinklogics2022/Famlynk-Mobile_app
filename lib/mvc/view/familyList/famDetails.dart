import 'package:famlynk_version1/mvc/model/familyMembers/famlist_modelss.dart';
import 'package:flutter/material.dart';


class MemberDetails extends StatefulWidget {
  MemberDetails({required this.details});
  final FamListModel details;

  @override
  State<MemberDetails> createState() => _MemberDetailsState();
}

class _MemberDetailsState extends State<MemberDetails>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.bounceInOut,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: const Color.fromARGB(255, 231, 238, 243),
      appBar: AppBar(
        title: Text("Family Member Details"),
      ),
      body: AnimatedContainer(
        duration: Duration(milliseconds: 800),
        decoration: BoxDecoration(
    
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 10),
            child: Column(
              children: [
                AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _animation.value,
                      child: CircleAvatar(
                        radius: 65,
                        backgroundImage:
                            NetworkImage(widget.details.image.toString()),
                      ),
                    );
                  },
                ),
                SizedBox(height: 20),
                Text(
                  "${widget.details.name.toString()}",
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDetailRow("Date of Birth", widget.details.dob.toString()),
                        _buildDetailRow("E-mail", widget.details.email.toString()),
                        _buildDetailRow("Gender", widget.details.gender.toString()),
                        _buildDetailRow("Mobile No", widget.details.mobileNo.toString()),
                        _buildDetailRow("Relation", widget.details.relation.toString()),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Text(
            "$label :",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
