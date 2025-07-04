vim9script

ddc#custom#patch_global("ui", "native")
ddc#custom#patch_global("sources", ["lsp"])
ddc#custom#patch_global("sourceOptions", { lsp: { isVolatile: true, mark: 'L', sorters: ['sorter_rank'] } })
ddc#custom#patch_global("sourceParams", { lsp: { lspEngine: "lspoints"} })
ddc#enable()
