# todo_app

This is just a todo app I developed to test my Flutter skill set. <br/>
Note that the school year has begun, so I can't complete this app in time, and the development is suspended (I can just write a bit of code when I'm free).

### How to run?

```sh
flutter pub get
flutter run
```

### Warnings for low-perf user:

I adjusted the Gradle build flags in the [`android/gradle.properties`](./android/gradle.properties) file as follows:

```properties
org.gradle.jvmargs=-Xmx3G -XX:+UseParallelGC
android.useAndroidX=true
android.enableJetifier=true
org.gradle.parallel=true
```

(My laptop has 8 GB of RAM, so I set the Gradle build heap size to 3 GB. Remember to adjust it when needed)

## Known limitations and TODOs:

- Not designed for desktop usage (I just enable desktop support for easier debugging).
- Using hivedb for storing data so we can't store the DateTimeRange data type. Planning to migrate to Isar.
- Long and spaghetti code, planning to refactor.
