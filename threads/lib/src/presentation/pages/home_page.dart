/**
 * @author [Frederic Chien]
 * @email [contato@kyuubi.com.br]
 * @create date 07-07-2023 15:21:40
 * @modify date 07-07-2023 15:21:40
 * @desc [description]
 */
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:threads/src/presentation/pages/profile_page.dart';
import 'package:threads/src/presentation/widgets/drawer.dart';
import 'package:threads/src/presentation/widgets/post.dart';
import 'package:threads/src/presentation/widgets/text_field.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //user
  final currentUser = FirebaseAuth.instance.currentUser!;

  final textController = TextEditingController();

  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  void postMessage() {
    if (textController.text.isNotEmpty) {
      FirebaseFirestore.instance.collection("User Posts").add({
        'UserEmail': currentUser.email,
        'Message': textController.text,
        'TimeStamp': Timestamp.now(),
        'Likes': [],
      });

      setState(() {
        textController.clear();
      });
    }
  }

  void goToProfilePage() {
    Navigator.pop(context);

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProfilePage(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home page'),
      ),
      drawer: MyDrawer(
        onProfileTap: goToProfilePage,
        onLogoutTap: signOut,
      ),
      body: Center(
        child: Column(
          children: [
            //messages
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("User Posts")
                    .orderBy(
                      "TimeStamp",
                      descending: false,
                    )
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final post = snapshot.data!.docs[index];
                        return Post(
                          message: post['Message'],
                          user: post['UserEmail'],
                          postId: post.id,
                          likes: List<String>.from(post['Likes'] ?? []),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        "Error: ${snapshot.error}",
                      ),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),

            //post a message
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Row(
                children: [
                  Expanded(
                    child: MyTextField(
                      controller: textController,
                      hintText: "Escreva sua idéia...",
                      obscureText: false,
                    ),
                  ),
                  IconButton(
                    onPressed: postMessage,
                    icon: const Icon(
                      Icons.arrow_circle_up,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),

            Text(
              "Logado como: " + currentUser.email.toString(),
              style: const TextStyle(
                color: Colors.yellow,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
      backgroundColor: Color(0xFF2e3192),
    );
  }
}
