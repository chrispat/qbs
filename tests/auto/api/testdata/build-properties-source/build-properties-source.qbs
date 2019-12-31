Project {
    Product {
        type: "application"
        consoleApplication: true
        name: "HelloWorld"

        Depends { name: 'cpp' }

        Properties {
            condition: qbs.toolchain.contains("gcc") && qbs.targetPlatform === qbs.hostPlatform
            cpp.cxxFlags: "-march=native"
        }

        Group {
            cpp.defines: ['WORLD="BANANA"']
            files : [ "main.cpp" ]
        }
    }
}

