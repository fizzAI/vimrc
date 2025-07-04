vim9script

def! g:AttachPyright()
	echom "Starting BasedPyright..."
	lspoints#attach('basedpyright', {
		cmd: ['basedpyright-langserver', "--stdio"],
		initializationOptions: {
			enable: true,
			suggest: {
				autoImports: false
			}
		}
	})
	echo ""
enddef

if &filetype == "python"
	g:AttachPyright()
endif
autocmd filetype python call g:AttachPyright()
