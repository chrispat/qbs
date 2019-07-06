Project {
    Product {
        property bool skip: {
            var result = qbs.targetOS.contains("ios");
            if (result)
                console.info("Skip this test");
            return result;
        }
        consoleApplication: true
        type: "application"
        name: "i"

        Depends {
            name: "Qt.core"
        }

        files: [
            "bla.cpp",
            "bla.qrc",
            //"test.cpp",
        ]
    }
}

