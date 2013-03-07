import qbs.base 1.0
import qbs.fileinfo as FileInfo
import '../utils.js' as ModUtils

GenericGCC {
    condition: qbs.targetOS === "windows" && qbs.toolchain === "mingw"
    staticLibraryPrefix: "lib"
    dynamicLibraryPrefix: ""
    executablePrefix: ""
    staticLibrarySuffix: ".a"
    dynamicLibrarySuffix: ".dll"
    executableSuffix: ".exe"
    platformDefines: base.concat(['UNICODE'])
    compilerDefines: ['__GNUC__', 'WIN32', '_WIN32']

    property string windresName: 'windres'
    property string windresPath: { return toolchainPathPrefix + windresName }

    setupBuildEnvironment: {
        var v = new ModUtils.EnvironmentVariable("PATH", ";", true);
        v.prepend(toolchainInstallPath);
        v.set();
    }

    FileTagger {
        pattern: "*.rc"
        fileTags: ["rc"]
    }

    Rule {
        inputs: ["rc"]

        Artifact {
            fileName: ".obj/" + product.name + "/" + input.baseDir.replace(':', '') + "/" + input.completeBaseName + "_res.o"
            fileTags: ["obj"]
        }

        prepare: {
            var platformDefines = ModUtils.moduleProperties(input, 'platformDefines');
            var defines = ModUtils.moduleProperties(input, 'defines');
            var includePaths = ModUtils.moduleProperties(input, 'includePaths');
            var systemIncludePaths = ModUtils.moduleProperties(input, 'systemIncludePaths');
            var args = [];
            var i;
            for (i in platformDefines) {
                args.push('-D');
                args.push(platformDefines[i]);
            }
            for (i in defines) {
                args.push('-D');
                args.push(defines[i]);
            }
            for (i in includePaths) {
                args.push('-I');
                args.push(includePaths[i]);
            }
            for (i in systemIncludePaths) {
                args.push('-isystem');
                args.push(systemIncludePaths[i]);
            }

            args = args.concat(['-i', input.fileName, '-o', output.fileName]);
            var cmd = new Command(ModUtils.moduleProperty(product, "windresPath"), args);
            cmd.description = 'compiling ' + FileInfo.fileName(input.fileName);
            cmd.highlight = 'compiler';
            return cmd;
        }
    }
}

