vim9script

import "lines9.vim"
import "lines9/utils.vim"
import "lines9/color.vim"

# AI GENERATED CODE USE AT OWN RISK
# Build label for one buffer
def BuildLabel(bnr: number): string
    var name = bufname(bnr) != '' ? fnamemodify(bufname(bnr), ':t') : '(No Name)'
    var mod  = getbufvar(bnr, '&modified') ? '[+]' : ''
    return $"{bnr}:{name}{mod}"
enddef

def BufferBar(opts: dict<any> = {}): dict<any>
    const conf = opts->extend({
        highlight: {
            current: { base: 'TabLine', name: 'Lines9BufferCurrent',
                       cterm: { bold: true, underline: false } },
	    inactive: { base: 'TabLine', name: 'Lines9BufferInactive', cterm: {underline: false} },
            modified: { base: 'WarningMsg', name: 'Lines9BufferModified' },
        },
        max_name_len: 20,
        sep: ' ',
    }, 'keep')

    # Map category -> resulting highlight group name
    const hlgroups = conf.highlight->mapnew((_, v) => type(v) == v:t_string ? v : v.name)

    return color.HlSchemeComponent(
        conf.highlight->values()->filter((_, v) => type(v) == v:t_dict),
        {
            value: utils.Dyn(utils.ToLegacyClosure((win) => {
                var curbuf = winbufnr(win)
                var pieces = []
		var first_buf_hl = ""
		for info in getbufinfo({buflisted: 1})
		    var bnr = info.bufnr
                    var label = BuildLabel(bnr)

                    if strlen(label) > conf.max_name_len
                        label = label[0 : conf.max_name_len - 2] .. '…'
                    endif

                    var hlcat = bnr == curbuf ? 'current' : 'inactive'
                    var hl = hlgroups[hlcat]

		    if first_buf_hl == ""
			first_buf_hl = hl
		    endif

                    if info.changed
                        label = color.Highlight(hlgroups.modified) .. label .. color.Highlight(hl)
                    endif

                    # Clickable part: left-click to switch to that buffer
		    var seg = color.Highlight(hl) ..
                              label
                    pieces->add(seg)
                endfor
                return color.Highlight(first_buf_hl) .. ' ' .. pieces->join('▕' .. '▏') .. '%T '
            }), true),
        }
    )
enddef
# END OF AI GENERATED CODE

var config = lines9.GetPreset("default")

config["schemes"]["active"] = ["mode", "paste", "fname", "modified", "bufferline", "sep", "fileinfo", "index"]
config["components"]["bufferline"] = BufferBar()

lines9.Init(config)

lines9.Enable()
