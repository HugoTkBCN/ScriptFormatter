output_modification() {
    [ ! -z ${option[-o]} ] && exec >${option[-o]}
}