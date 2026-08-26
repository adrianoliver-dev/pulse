allprojects {
    repositories {
        google()
        mavenCentral()
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
    pluginManager.withPlugin("com.android.library") {
        val android = extensions.getByName("android")
        val current =
            android.javaClass.methods
                .firstOrNull { it.name == "getNamespace" && it.parameterCount == 0 }
                ?.invoke(android) as? String
        if (current.isNullOrBlank()) {
            val fallback = group.toString().ifBlank { "missing.namespace.$name" }
            android.javaClass.methods
                .first { it.name == "setNamespace" && it.parameterCount == 1 }
                .invoke(android, fallback)
        }
    }
}

subprojects {
    afterEvaluate {
        extensions.findByName("android")?.let { android ->
            for (method in android.javaClass.methods) {
                if (method.parameterCount != 1) continue
                if (method.name != "setCompileSdk" && method.name != "setCompileSdkVersion") continue
                val type = method.parameterTypes[0]
                try {
                    when (type) {
                        Int::class.javaPrimitiveType, Integer::class.java -> method.invoke(android, 37)
                        String::class.java -> method.invoke(android, "android-37")
                    }
                } catch (_: Exception) {
                }
            }
        }
        tasks.withType<JavaCompile>().configureEach {
            sourceCompatibility = JavaVersion.VERSION_17.toString()
            targetCompatibility = JavaVersion.VERSION_17.toString()
        }
        tasks.withType<org.jetbrains.kotlin.gradle.tasks.KotlinCompile>().configureEach {
            compilerOptions {
                jvmTarget.set(org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17)
            }
        }
    }
}

subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
