" Modified from https://github.com/vim-test/vim-test/blob/master/autoload/test/csharp/dotnettest.vim
" This uses the GdUnit4 CLI: https://mikeschulze.github.io/gdUnit4/advanced_testing/cmd/

if !exists('g:test#csharp#gdunit4#file_pattern')
  let g:test#csharp#gdunit4#file_pattern = '\v\.cs$'
endif

function! test#csharp#gdunit4#test_file(file) abort
  if fnamemodify(a:file, ':t') =~# g:test#csharp#gdunit4#file_pattern
    if exists('g:test#csharp#runner')
      return g:test#csharp#runner ==# 'gdunit4'
    endif
    return 1
  endif
endfunction

function! test#csharp#gdunit4#build_position(type, position) abort
  let file = a:position['file']
  let filename = fnamemodify(file, ':t:r')
  let project_path = test#csharp#get_project_path(file)
	let project_dir = fnamemodify(file, ':p:h:t')
  let name = test#base#nearest_test(a:position, g:test#csharp#patterns, { 'namespaces_with_same_indent': 1 })
  let namespace = join(name['namespace'], '.')
  let test_name = join(name['test'], '.')
  let nearest_test = join([namespace, test_name], '.')

  if a:type ==# 'nearest'
		return ['--add', file, '--continue']
    " if !empty(test_name)
    "   return [project_path, '--filter', 'FullyQualifiedName=' . nearest_test]
    " else
    "   if !empty(namespace)
    "     return [project_path, '--filter', 'FullyQualifiedName~' . namespace]
    "   else
    "     return [project_path]
    "   endif
    " endif
  elseif a:type ==# 'file'
		return ['--add', file, '--continue']
  elseif a:type ==# 'suite'
    if !empty(project_path)
      return ['--add', project_dir, '--continue']
    else
      return []
    endif
  endif
endfunction

function! test#csharp#gdunit4#build_args(args) abort
  let args = a:args
  return [join(args, ' ')]
endfunction

function! test#csharp#gdunit4#executable() abort
	return './addons/gdUnit4/runtest.sh'
endfunction
