/*A controller class that allows report_page to send email to a particular email.
In this case the email is set to be a mutual email address set up by the development team.
When a report is filed, developers can validate the information and edit the database accordingly.
 */

import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class SendEmail{


  void sendReportDetails(String subject, String content, String name) async {
    String username = 'noturningbackcz2006@gmail.com';
    String password = 'qweqwe123!!!';

    final smtpServer = gmail(username, password);

    // Create our message
    final message = Message()
      ..from = Address(username, name)
      ..recipients.add('noturningbackcz2006@gmail.com')
//      ..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com'])
//      ..bccRecipients.add(Address('bccAddress@example.com'))
      ..subject = subject +' on ${DateTime.now()}'
      ..text = content ;
//      ..html = "<h1>Test</h1>\n<p>Hey! Here's some HTML content</p>";

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }
}