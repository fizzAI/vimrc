vim9script

g:plugpac_plugin_conf_path = expand('<sfile>:p:h:h') .. "/rc"

plugpac#Begin({
  status_open: 'vertical',
  verbose: 2,
  quiet: v:false, # show no warning if any package is not installed
})

# minpac
Pack 'k-takata/minpac', {'type': 'opt'}

Pack 'tpope/vim-sensible'
Pack 'girishji/vimbits'

Pack '91khr/lines9', { 'type': 'delay' }

Pack 'vim-denops/denops.vim'

Pack 'kuuote/lspoints'
Pack 'Shougo/ddc-ui-native', {'type': 'delay'}
Pack 'Shougo/ddc-source-lsp', {'type': 'delay'}
Pack 'Shougo/ddc-filter-sorter_rank', {'type': 'delay'}
Pack 'Shougo/ddc.vim', { 'type': 'delay' }

Pack 'dstein64/vim-startuptime', { 'on': 'StartupTime' }
plugpac#End()
