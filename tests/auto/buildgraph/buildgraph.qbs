import qbs

QbsAutotest {
    Depends { name: "qbslogging" }
    testName: "buildgraph"
    condition: qbsbuildconfig.enableUnitTests
    files: [
        "tst_buildgraph.cpp",
        "tst_buildgraph.h"
    ]
}
