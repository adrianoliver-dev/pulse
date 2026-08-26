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
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
