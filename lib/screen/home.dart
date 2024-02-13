/*
 * "ttorok" created by @howyoujini on 2/11/24  2:33 PM
 * Copyright (c) . All rights reserved.
 */
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ttorok/schemes/color_schemes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        notificationPredicate: (_) => false,
        backgroundColor: context.color.background,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(
              'assets/logo/ttorok_logo.svg',
              width: 50,
            ),
            const Flexible(
              flex: 1,
              child: TextField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 12),
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(0))),
                  hintText: '또봇으로 저장했던 키워드나 궁금한 사람을 검색해보세요.',
                ),
              ),
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text('dbwls'),
          );
        },
      ),
    );
  }
}
