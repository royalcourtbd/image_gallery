import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
        centerTitle: true,
        backgroundColor: const Color(0xffF4C2C2),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: [
            buildHeaderText(
                textTheme: textTheme, text: 'Privacy Policy for Image Gallery'),
            const Gap(8),
            Text(
              'Effective date: 15 - February - 2024',
              style: textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
            ),
            const Gap(15),
            buildBodyText(
              textTheme: textTheme,
              text:
                  'This privacy policy ("Policy") describes how the Image Gallery mobile application (\'App\') collects, uses, and shares information about you. This Policy applies to all users of the App. By using the App, you agree to the collection and use of information in accordance with this Policy. If you do not agree with the terms of this Policy, do not access or use the App.',
            ),
            const Gap(15),
            Text(
              'Information Collection and Use',
              style: textTheme.headlineMedium,
            ),
            const Gap(8),
            buildBodyText(
                textTheme: textTheme,
                text:
                    'The Image Gallery App does not collect or store any personal information from its users. We are committed to respecting your privacy and recognizing the need for appropriate protection and management of any personal information you share with us.'),
            const Gap(15),
            buildHeaderText(textTheme: textTheme, text: "Internet Permission"),
            const Gap(8),
            buildBodyText(
                textTheme: textTheme,
                text:
                    'Our App requires internet permission solely to access online resources and functionalities. This permission is used to enhance the user experience by enabling features such as browsing online galleries. We do not collect or store any data transmitted over the internet while using the App.'),
            const Gap(15),
            buildHeaderText(
                textTheme: textTheme, text: "Data Sharing and Disclosure"),
            const Gap(8),
            buildBodyText(
                textTheme: textTheme,
                text:
                    'Since we do not collect or store personal information, we have no data to share or disclose to third parties.'),
            const Gap(15),
            buildHeaderText(
                textTheme: textTheme, text: "Changes to This Privacy Policy"),
            const Gap(8),
            buildBodyText(
                textTheme: textTheme,
                text:
                    'We may update our Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy on this page. You are advised to review this Privacy Policy periodically for any changes. Changes to this Privacy Policy are effective when they are posted on this page.'),
            const Gap(15),
            buildHeaderText(textTheme: textTheme, text: "Contact Us"),
            const Gap(8),
            buildBodyText(
                textTheme: textTheme,
                text:
                    'If you have any questions about this Privacy Policy, please contact us. royalcourtbd@gmail.com'),
          ],
        ),
      ),
    );
  }

  Text buildBodyText({required TextTheme textTheme, required String text}) {
    return Text(
      text,
      style: textTheme.bodyMedium,
    );
  }

  Text buildHeaderText({required TextTheme textTheme, required String text}) {
    return Text(
      text,
      style: textTheme.headlineSmall,
    );
  }
}
