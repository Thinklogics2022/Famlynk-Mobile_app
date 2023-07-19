// body: Container(
    //   child: StreamBuilder<QuerySnapshot>(
    //     stream: FirebaseFirestore.instance.collection('imageURLs').snapshots(),
    //     builder:
    //     (context, snapshot) {
    //       if (snapshot.connectionState == ConnectionState.waiting) {
    //         return Center(
    //           child: CircularProgressIndicator(),
    //         );
    //       } else if (snapshot.hasError) {
    //         return Center(
    //           child: Text('Error: ${snapshot.error}'),
    //         );
    //       } else {
    //         final documents = snapshot.data!.docs;
    //         downloadedImageUrls = documents.map((doc) => doc.get('url') as String).toList();
    //         return ListView.builder(
    //           itemCount: documents.length,
    //           itemBuilder: (context, index) {
    //             final imageUrl = documents[index].get('url') as String;
    //             return Column(
    //               children: [
    //                 Padding(
    //                   padding: const EdgeInsets.all(10.0),
    //                   child: Row(
    //                     children: [
    //                       CircleAvatar(),
    //                       SizedBox(width: 10),
    //                       Column(
    //                         crossAxisAlignment: CrossAxisAlignment.start,
    //                         children: [
    //                           Text('jai'),
    //                           Text('05:20-26-06-2023'),
    //                         ],
    //                       ),
    //                       Spacer(),
    //                       PopupMenuButton<int>(
    //                         icon: Icon(Icons.more_vert),
    //                         iconSize: 18,
    //                         itemBuilder: (context) => [
    //                           PopupMenuItem<int>(
    //                             value: index,
    //                             child: Container(
    //                               height: 15,
    //                               child: Row(
    //                                 children: [
    //                                   Icon(Icons.delete, size: 18),
    //                                   SizedBox(width: 6),
    //                                   Text('Delete', style: TextStyle(fontSize: 14)),
    //                                 ],
    //                               ),
    //                             ),
    //                           ),
    //                         ],
    //                         onSelected: (value) {
    //                           deleteImage(documents[value].id);
    //                         },
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //                 Container(
    //                   child: Padding(
    //                     padding: const EdgeInsets.all(10.0),
    //                     child: FadeInImage.memoryNetwork(
    //                       fit: BoxFit.cover,
    //                       placeholder: kTransparentImage,
    //                       image: imageUrl,
    //                     ),
    //                   ),
    //                 ),
    //                 Divider(thickness: .5),
    //                 Padding(
    //                   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
    //                   child: Row(
    //                     mainAxisAlignment: MainAxisAlignment.start,
    //                     children: [
    //                       IconButton(
    //                         onPressed: () {},
    //                         icon: Icon(Icons.favorite_border),
    //                       ),
    //                       Text('10'),
    //                       Spacer(),
    //                       IconButton(
    //                         onPressed: () {},
    //                         icon: Icon(Icons.comment),
    //                       ),
    //                       Text('Comments'),
    //                     ],
    //                   ),
    //                 ),
    //                 Divider(thickness: 2.0),
    //               ],
    //             );
    //           },
    //         );
    //       }
    //     },
    //   ),
    // )
    // class PostCard extends StatelessWidget {
//   final NewsFeedModel post;

//   PostCard({required this.post});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: Column(
//         children: [
//           Image.network(post.photo),
//           ListTile(
//             title: Text(post.name),
//             subtitle: Text(post.description),
//             // trailing: Text('Likes: ${post.likesCount}'),
//           ),
//         ],
//       ),
//     );
//   }
// }

// Future<List<NewsFeedModel>> fetchPosts() async {
//   final response = await http.get(Uri.parse(FamlynkServiceUrl.gallery));

//   if (response.statusCode == 200) {
//     final List<dynamic> data = jsonDecode(response.body);
//     return data.map((json) => NewsFeedModel.fromJson(json)).toList();
//   } else {
//     throw Exception('Failed to fetch posts');
//   }
// }