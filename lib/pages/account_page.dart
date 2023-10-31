// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import '../user.dart';

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            CircleAvatar(
              radius: 80,
              // backgroundImage: AssetImage('assets/profile_image.jpg'),
            ),
            SizedBox(height: 10),
            Text(
              'Username',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildPopupButton(context, 'About Us'),
                  _buildPopupButton(context, 'Settings'),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'Statystyki:',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  _buildStatItem('Obecny Streak', currentUser.getDayStreak().toString()),
                  _buildStatItem('Ukończone zadania', currentUser.getFinishedTasks().toString()),
                  _buildStatItem('Nieukończone zadania', currentUser.getFailedTasks().toString()),
                  _buildStatItem('Wykonanych zadań', currentUser.getTaskCompletion().toString() + '%'),
                  _buildStatItem('Rekord Fiszki Rush', currentUser.getHighScoreFCRush().toString()),
                  _buildStatItem('Ukończone Fiszki', currentUser.getDayStreak().toString()),
                  _buildStatItem('Najdłuższy Streak', currentUser.getLongestStreak().toString()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPopupButton(BuildContext context, String title) {
    return ElevatedButton(
      onPressed: () {
        // Show the corresponding pop-up based on the title
        // You can implement this part based on your requirements
      },
      child: Text(title),
    );
  }

  Widget _buildStatItem(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 16),
        ),
        Text(
          value,
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: AccountPage(),
  ));
}
