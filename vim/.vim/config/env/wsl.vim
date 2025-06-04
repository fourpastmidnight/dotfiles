" ============================================================================
" WSL-specific configuration
" ============================================================================

if exists('g:loaded_wsl_config')
    finish
endif
let g:loaded_wsl_config = 1

" Detect WSL (this assumes g:is_wsl was already set in your main vimrc)
if !exists('g:is_wsl') || g:is_wsl == 0
    finish
endif

" ----------------------------------------------------------------------------
" Clipboard integration for WSL
" ----------------------------------------------------------------------------

if has("clipboard")
    " Wayland clipboard (WSLg or WSL2 with Wayland)
    if exists('$WAYLAND_DISPLAY') && executable('wl-copy') && executable('wl-paste')
        let g:clipboard = {
                    \   'name': 'wl-clipboard',
                    \   'copy': {
                    \       '+': 'wl-copy --foreground --type text/plain',
                    \       '*': 'true',
                    \   },
                    \   'paste': {
                    \       '+': 'wl-paste --no-newline',
                    \       '*': 'wl-paste --no-newline --primary',
                    \   },
                    \   'cache_enabled': 0,
                    \ }
    " Windows clipboard fallback (clip.exe + powershell.exe)
    elseif executable('clip.exe') && executable('powershell.exe')
        let g:clipboard = {
                    \   'name': 'WslClipboard',
                    \   'copy': {
                    \       '+': 'iconv -f utf-8 -t utf-16le | clip.exe',
                    \       '*': 'true',
                    \   },
                    \   'paste': {
                    \       '+': 'powershell.exe -NoProfile Get-Clipboard | iconv -f utf-16le -t utf-8',
                    \       '*': 'powershell.exe -NoProfile Get-Clipboard | iconv -f utf-16le -t utf-8',
                    \   },
                    \   'cache-enabled': 0,
                    \ }
    endif
endif
