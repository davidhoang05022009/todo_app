# todo_app

This is just a todo app I developed to test my Flutter skill set. <br/>
Note that the school year is begun, so I can't complete this app in time, so the development is suspended.

### How to run?
```sh
flutter pub get
flutter run
```

### Wait, how did it build the Android build so quickly?

I adjusted the Gradle build flags in the [`android/gradle.properties`](./android/gradle.properties) file as follows:
```properties
org.gradle.jvmargs=-Xmx3G -XX:+UseParallelGC
android.useAndroidX=true
android.enableJetifier=true
org.gradle.parallel=true
```

(My laptop has 8 GB of RAM, so I set the Gradle build heap size to 3 GB.)