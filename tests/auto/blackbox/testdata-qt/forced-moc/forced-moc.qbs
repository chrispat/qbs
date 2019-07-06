QtApplication {
    property bool skip: {
        var result = qbs.targetOS.contains("ios");
        if (result)
            console.info("Skip this test");
        return result;
    }

    files: "main.cpp"
    Group {
        name: "QObject service provider"
        files: "createqtclass.h"
        fileTags: ["hpp", "unmocable"]
    }
    Group {
        name: "QObject service user"
        files: "myqtclass.h"
        fileTags: ["hpp", "mocable"]
    }
}
