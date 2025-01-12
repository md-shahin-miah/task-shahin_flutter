


import 'package:flutter/material.dart';

// class HomeScreenView extends StatelessWidget {
//   const HomeScreenView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }
import 'package:flutter/material.dart';

import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import '../../../../config/themes/styles/app_colors.dart';
import '../../../widgets/common/custom_text_field.dart';
import '../../../widgets/common/reactions.dart';


class HomeScreenView extends StatelessWidget {
  final _conWriteHere = TextEditingController();

  @override
  Widget build(BuildContext context) {
    int rtnindex = -1;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: AppColors.primary,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Image.asset(
            "assets/menu.png",
            width: 36,
            height: 36,
          ),
        ),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Python Developer Community",
              style: TextStyle(fontSize: 18, color: AppColors.txtColor2, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 2),
            Text(
              "#General",
              style: TextStyle(fontSize: 14, color: Colors.white70),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(15),
            padding: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              color: AppColors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 5,
                  spreadRadius: 2,
                ),
              ],
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              children: [
                Container(
                  width: 65,
                  height: 65,
                  decoration: const BoxDecoration(
                    image: DecorationImage(image: AssetImage('assets/image.png')),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: CustomTextField(
                    controller: _conWriteHere,
                    isBorder: false,
                    hintText: 'Write something here...', isPassword:false ,
                  ),
                ),
                const SizedBox(width: 10),
                // CustomButtom(
                //   btnText: 'Post',
                //   width: null,
                //   textSize: 14,
                //   toggleObscure: () {},
                //   bgColor: AppColors.primaryDark,
                // )
              ],
            ),
          ),
          // ListView Section
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 5,
                          spreadRadius: 2,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundImage: AssetImage('assets/user_avatar.png'),
                            ),
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Alexander John",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "2 days ago",
                                  style: TextStyle(fontSize: 12, color: Colors.grey),
                                ),
                              ],
                            ),
                            Spacer(),
                            Icon(Icons.more_vert),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Hello everyone - This is a post from the app.",
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(height: 10),
                        if (index % 2 == 0) // Example image for alternating items
                          Container(
                            width: double.infinity,
                            height: 180,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: const DecorationImage(
                                image: AssetImage('assets/post_image.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        const SizedBox(height: 10),
                        InkWell(
                          onTap: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  // makeLike(),
                                  // Transform.translate(offset: const Offset(-5, 0), child: makeLove()),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "100",
                                    style: TextStyle(fontSize: 15, color: Colors.grey[800]),
                                  )
                                ],
                              ),
                              Text(
                                "No Comments",
                                style: TextStyle(fontSize: 13, color: Colors.grey[800]),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                              child: ReactionButton<String>(
                                itemSize: const Size.square(40),
                                onReactionChanged: (Reaction<String>? reaction) {},
                                reactions: reactions,
                                placeholder: rtnindex != -1 ? reactions[rtnindex] : defaultInitialReaction,
                                selectedReaction: reactions.first,
                              ),
                            ),
                            buildReactionsIcon(
                              'assets/comment.png',
                              const Text(
                                'Comment',
                                style: TextStyle(
                                  color: Color(0XFF000000),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.groups,
              color: AppColors.primary,
            ),
            label: 'Community',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.output,
              color: AppColors.primary,
            ),
            label: 'Logout',
          ),
        ],
        backgroundColor: Colors.white,
        selectedItemColor: Colors.teal,
      ),
    );
  }
}