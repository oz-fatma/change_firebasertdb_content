# change_firebasertdb_content_withflutterapp

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


Steps:

1. Create new flutter application Android studio or Visual Studio Code editör.
2. Go  to firebase console and create a firebase project.
3. Go to your project and add app.You should select Android app.
4. Follow firebase adding android app instructons.
5. Your app name is in the "yourprojectname/android/app/build.gradle" file in the defaultConfig.Your applicationId here.
6. Copy and paste app name firebase android app name part.
7. You can create SHA1 certificate or skip .Then continue.
8. Download google-services.json and copy it, paste it yourprojectname/android/app/src directory.
9. Follow firebase instructions and done.
10. Add firebase database project dependencies in pubsec.yaml and import it where to use.
11. Create a new real time database in firebase by following firebase instructions.
12. Your database content shooul be like this:

YourDatabaseName
“suDeposu”:
{
   ”dolululukOranı”: “ 80”,
   “ad”: “su deposu”,
}

“box”:
{
 “ad”:”kutu”

}
 


Example data update method:
 void updateData() {

    databaseReference.child("yourPath").child("yourChildPath").update({'value: yourValue});

  }
