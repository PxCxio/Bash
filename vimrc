syntax on
:set number relativenumber

:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END
set runtimepath^=~/.vim/bundle/ctrlp.vim

"let g:sparkup = 'sparkup'
":let g:sparkup  (Default: 'sparkup')
    " Location of the sparkup executable. You shouldn't need to change this
    " setting if you used the install option above.

"let g:sparkupArgs (Default: '--no-last-newline') -
    " Additional args passed to sparkup.

"let g:sparkupExecuteMapping = '<c-H>'
"let  g:sparkupExecuteMapping (Default: '<c-e>') -
    " Mapping used to execute sparkup within insert mode.

"let g:sparkupNextMapping (Default: '<c-n>') -
    " Mapping used to jump to the next empty tag/attribute within insert mode.

"let g:sparkupMaps (Default: 1) -
    " Set up automatic mappings for Sparkup. If set to 0, this can be
    " used to disable creation of any mappings, which is useful if
    " full customisation is required.

let g:sparkupMapsNormal = 1 "(Default: 0) -
   "   Set up mappings for normal mode within Vim. The same execute and next
   "  mappings configured above will apply to normal mode if this option is
   "  set.




