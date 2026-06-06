// 1. أضف هذا القسم في بداية الملف إذا لم يكن موجوداً، فهو ضروري لعمل أدوات البناء
buildscript {
    repositories {
        google()
        mavenCentral()
    }
}

// 2. تعديل قسم allprojects الخاص بك ليتضمن مستودع فلاتر
allprojects {
    repositories {
        google()
        mavenCentral()
        // هذا السطر هو المفتاح لحل مشكلتك وحقن مكتبات فلاتر الناقصة
        maven { url = uri("https://storage.googleapis.com/download.flutter.io") }
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}

subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}