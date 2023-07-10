import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:threads/src/presentation/widgets/comment.dart';
import 'package:threads/src/presentation/widgets/delete_button.dart';
import 'package:threads/src/presentation/widgets/like_button.dart';

import '../../utils/helper_methods.dart';
import 'comments_button.dart';

class Post extends StatefulWidget {
  final String message;
  final String user;
  final String postId;
  final String time;
  final List<String> likes;

  const Post({
    super.key,
    required this.message,
    required this.user,
    required this.postId,
    required this.likes,
    required this.time,
  });

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  bool isLiked = false;
  final _commentTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isLiked = widget.likes.contains(currentUser.email);
  }

  //like a post
  void toggleLike() {
    setState(() {
      isLiked = !isLiked;

      DocumentReference postRef = FirebaseFirestore.instance
          .collection('User Posts')
          .doc(widget.postId);

      if (isLiked) {
        postRef.update({
          'Likes': FieldValue.arrayUnion([currentUser.email])
        });
      } else {
        postRef.update({
          'Likes': FieldValue.arrayRemove([currentUser.email])
        });
      }
    });
  }

  //delete post
  void deletePost() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Deletar idéia"),
        content: const Text("Você tem certeza que deseja deletar sua idéia?"),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar')),
          TextButton(
              onPressed: () async {
                //delete comments first
                final commentDocs = await FirebaseFirestore.instance
                    .collection("User Posts")
                    .doc(widget.postId)
                    .collection("Comments")
                    .get();

                for (var doc in commentDocs.docs) {
                  await FirebaseFirestore.instance
                      .collection("User Posts")
                      .doc(widget.postId)
                      .collection("Comments")
                      .doc(doc.id)
                      .delete();
                }

                await FirebaseFirestore.instance
                    .collection("User Posts")
                    .doc(widget.postId)
                    .delete()
                    .then((value) => print("Post deletado"))
                    .catchError((error) => print("Falha ao deletar: $error"));

                Navigator.pop(context);
              },
              child: const Text('Apagar')),
        ],
      ),
    );
  }

  //add a comment
  void addComments(String commentText) {
    FirebaseFirestore.instance
        .collection("User Posts")
        .doc(widget.postId)
        .collection("Comments")
        .add({
      "CommentText": commentText,
      "CommentBy": currentUser.email,
      "CommentTime": Timestamp.now()
    });
  }

  void showCommentsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Adicione um comentário"),
        content: TextField(
          controller: _commentTextController,
          decoration: InputDecoration(hintText: "Escreva seu comentário"),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _commentTextController.clear();
            },
            child: Text("Cancelar"),
          ),
          TextButton(
            onPressed: () {
              addComments(_commentTextController.text);
              Navigator.pop(context);
              _commentTextController.clear();
            },
            child: Text("Postar"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      margin: EdgeInsets.only(top: 25, left: 25, right: 25),
      padding: EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //posts on home
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //group of text
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.message,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        widget.user,
                        style: TextStyle(color: Colors.grey[500]),
                      ),
                      Text(
                        ' - ',
                        style: TextStyle(color: Colors.grey[500]),
                      ),
                      Text(
                        widget.time,
                        style: TextStyle(color: Colors.grey[500]),
                      ),
                    ],
                  ),
                ],
              ),
              //delete button

              if (widget.user == currentUser.email)
                DeleteButton(onTap: deletePost)
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //like button
              Column(
                children: [
                  LikeButton(
                    isLiked: isLiked,
                    onTap: toggleLike,
                  ),
                  const SizedBox(height: 5),
                  Text(widget.likes.length.toString()),
                ],
              ),
              const SizedBox(
                width: 10,
              ),
              //comments button
              Column(
                children: [
                  CommentButton(
                    onTap: showCommentsDialog,
                  ),
                  const SizedBox(height: 5),
                  Text('0'),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          //comments for posts
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("User Posts")
                .doc(widget.postId)
                .collection("Comments")
                .orderBy("CommentTime", descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: snapshot.data!.docs.map((doc) {
                  final commentData = doc.data() as Map<String, dynamic>;

                  return Comment(
                    text: commentData['CommentText'],
                    user: commentData['CommentBy'],
                    time: formatData(commentData['CommentTime']),
                  );
                }).toList(),
              );
            },
          )
        ],
      ),
    );
  }
}
