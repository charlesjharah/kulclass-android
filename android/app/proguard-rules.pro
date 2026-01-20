# Zego Rules
-keep class **.zego.** { *; }
-keep class **.**.zego_zpns.** { *; }

# DeepAR Rules
-keep class ai.deepar.ar.** { *; }
-keepclassmembers class * {
    @android.webkit.JavascriptInterface <methods>;
}

# General Rules
-keepattributes *Annotation*
-optimizations !method/inlining/*
-keepclasseswithmembers class * {
  public void onPayment*(...);
}

# Google/AdMob Rules
-dontwarn com.google.ads.mediation.admob.AdMobAdapter
-keep public class com.google.android.gms.ads.** {
    public *;
}

# Firebase & Google Play Services Rules
-keep class com.google.firebase.** { *; }
-keep class com.google.android.gms.** { *; }
-keep class com.google.android.gms.internal.** { *; }

# Firebase Messaging Specific Rules
-keep class com.google.firebase.messaging.FirebaseMessagingService { *; }
-keep class com.google.firebase.messaging.FirebaseMessagingService$JobIntentService { *; }
-keep class com.google.firebase.messaging.RemoteMessage { *; }
-keep class com.google.firebase.messaging.RemoteMessage$Builder { *; }
-keep class com.google.firebase.messaging.RemoteMessage$Notification { *; }
-keep class com.google.firebase.messaging.RemoteMessage$Notification$Builder { *; }

# Firebase Performance Monitoring Rules
-keep class com.google.android.gms.internal.firebase.** { *; }
-dontwarn com.google.android.gms.internal.firebase-perf.**

# Firebase Crashlytics Rules
-keepattributes Exceptions, InnerClasses, Signature, SourceFile, LineNumber
-keep public class com.google.firebase.crashlytics.** { *; }
-keep class com.google.firebase.crashlytics.internal.** { *; }

# Firebase Remote Config Rules
-keep class com.google.firebase.remoteconfig.** { *; }

# Flutter Plugin-specific Rules
-keep class io.flutter.plugins.firebase.** { *; }
-keep class io.flutter.plugins.firebase_core.** { *; }
-keep class io.flutter.plugins.firebase_core_platform_interface.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class dev.flutter.pigeon.** { *; }
-dontwarn com.razorpay.**
-keep class com.razorpay.** {*;}