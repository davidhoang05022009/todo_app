# todo_app

This is just a todo app I developed to test my Flutter skill set.

### How to run?
```sh
flutter pub get
flutter run
```

### Wait, how did it build the Android build so quickly?

I adjusted the Gradle build flags in the [`gradle.properties`](./android/gradle.properties) file as follows:
```properties
org.gradle.jvmargs=-Xmx1536M -XX:+UseParallelGC
android.useAndroidX=true
android.enableJetifier=true
org.gradle.parallel=true
```