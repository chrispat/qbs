import qbs
import qbs.FileInfo
import qbs.Utilities

QtApplication {
    type: ["application", "autotest"]
    consoleApplication: true
    property string testName
    name: "tst_" + testName
    property string targetInstallDir: qbsbuildconfig.appInstallDir
    Depends { name: "Qt.testlib" }
    Depends { name: "qbscore" }
    Depends { name: "qbsbuildconfig" }
    cpp.defines: [
        "QBS_TEST_SUITE_NAME=" + Utilities.cStringQuote(testName.toUpperCase().replace("-", "_"))
    ]
    cpp.includePaths: [
        "../../../src",
    ]
    cpp.cxxLanguageVersion: "c++14"
    cpp.rpaths: qbsbuildconfig.libRPaths

    qbs.commonRunEnvironment: ({
        "QBS_INSTALL_DIR": FileInfo.joinPaths(qbs.installRoot, qbs.installPrefix)
    })
    Group {
        fileTagsFilter: product.type
        qbs.install: true
        qbs.installDir: targetInstallDir
    }
}
