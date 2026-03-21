import java.io.FileInputStream
import java.util.Properties
import org.gradle.api.GradleException

plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")
    id("dev.flutter.flutter-gradle-plugin")
}

val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties")

if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
}

android {
    namespace = "com.geryon.scavium_wallet"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        applicationId = "com.geryon.scavium_wallet"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        create("release") {
            val storeFilePath = keystoreProperties.getProperty("storeFile")
            val storePasswordValue = keystoreProperties.getProperty("storePassword")
            val keyAliasValue = keystoreProperties.getProperty("keyAlias")
            val keyPasswordValue = keystoreProperties.getProperty("keyPassword")

            if (storeFilePath.isNullOrBlank()) {
                throw GradleException("Missing 'storeFile' in android/key.properties")
            }
            if (storePasswordValue.isNullOrBlank()) {
                throw GradleException("Missing 'storePassword' in android/key.properties")
            }
            if (keyAliasValue.isNullOrBlank()) {
                throw GradleException("Missing 'keyAlias' in android/key.properties")
            }
            if (keyPasswordValue.isNullOrBlank()) {
                throw GradleException("Missing 'keyPassword' in android/key.properties")
            }

            val resolvedStoreFile = rootProject.file(storeFilePath)
            if (!resolvedStoreFile.exists()) {
                throw GradleException("Keystore file not found: ${resolvedStoreFile.absolutePath}")
            }

            storeFile = resolvedStoreFile
            storePassword = storePasswordValue
            keyAlias = keyAliasValue
            keyPassword = keyPasswordValue
        }
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("release")
            isMinifyEnabled = false
            isShrinkResources = false
        }
    }
}

flutter {
    source = "../.."
}