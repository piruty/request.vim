let s:request_result_buffer = 'REQUEST'

function! request#request() abort
  let res = webapi#http#get('https://google.com')

  if res.status != 200
    echo 'request failed. response status: ' . res.status
    return
  endif

  if bufexists(s:request_result_buffer)
    let winid = bufwinid(s:request_result_buffer)
    if winid isnot# -1
      call win_gotoid(winid)
    else
      execute 'sbuffer' s:request_result_buffer
    endif
  else
    execute 'new' s:request_result_buffer

    set buftype=nofile

    nnoremap <silent> <buffer> <Plug>(request-close) :<C-u>bwipeout!<CR>

    nmap <buffer> q <Plug>(request-close)
  endif

  %delete _
  call setline(1, res.content)
endfunction
