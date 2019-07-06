import qbs.Probes

Project {
    property bool skip: {
        var result = qbs.targetOS.contains("ios");
        if (result)
            console.info("Skip this test");
        return result;
    }
    property string name: 'pkgconfig'
    CppApplication {
        name: project.name
        Probes.PkgConfigProbe {
            id: pkgConfig
            name: "QtCore"
            minVersion: '4.0.0'
            maxVersion: '5.99.99'
        }
        files: 'main.cpp'
        cpp.cxxFlags: pkgConfig.cflags
        cpp.linkerFlags: pkgConfig.libs
    }
}
