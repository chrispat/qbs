Product {
    Depends { name: "cpp" }
    files: ["gsl/*"]
    cpp.includePaths: [product.sourceDirectory]
    Export {
        Depends { name: "cpp" }
        cpp.includePaths: [product.sourceDirectory]
    }
}
