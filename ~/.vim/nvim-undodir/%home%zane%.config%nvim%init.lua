Vim�UnDo� ��H��ĕ |;X���苦-5�hD+�u�|�  i                                   b���    _�                    x        ����                                                                                                                                                                                                                                                                                                                        �          x           V        b���     �  w  x              "----------------------------------   --           Startify   "----------------------------------   cmd([[    let g:startify_custom_header = [   &\ '   ___      ___ ___  _____ ______',   )\ '  |\  \    /  /|\  \|\   _ \  _   \ ',   *\ '  \ \  \  /  / | \  \ \  \\\__\ \  \ ',   +\ '   \ \  \/  / / \ \  \ \  \\|__| \  \ ',   +\ '    \ \    / /   \ \  \ \  \    \ \  \',   ,\ '     \ \__/ /     \ \__\ \__\    \ \__\',   ,\ '      \|__|/       \|__|\|__|     \|__|',   \ ]   ]])5��    w                     yN      �              5�_�                   x        ����                                                                                                                                                                                                                                                                                                                        x          x           V        b���     �  v  x  �      }    �  w  y  �       5��    v                    xN                     5�_�                   �        ����                                                                                                                                                                                                                                                                                                                        �          �           V        b���     �  �  �          "----------------------------------   --           ultisnips   "----------------------------------   !g.UltiSnipsExpandTrigger= '<c-e>'5��    �                     WO                     5�_�                   w        ����                                                                                                                                                                                                                                                                                                                        �          �           V        b���    �  w  y  �    5��    w                     yN                     5�_�                     �        ����                                                                                                                                                                                                                                                                                                                         �                     V        b���    �   �   �          &-- ----------------------------------'   &-- --      Compilation/Execution     '   &-- ----------------------------------'   -- augroup exe   -- 	-- C   F-- 	autocmd filetype c nnoremap <F4> :w<cr> :!clang *.c && ./a.out<cr>   L-- 	autocmd filetype c inoremap <F4> <Esc> :w<cr> :!clang *.c && ./a.out<cr>   
-- 	-- C++   d-- 	autocmd filetype cpp nnoremap <F4> :w<cr> :!clang++-5.0 -std=c++11 -Wall -g *.cpp && ./a.out<cr>   j-- 	autocmd filetype cpp inoremap <F4> <Esc> :w<cr> :!clang++-5.0 -std=c++11 -Wall -g *.cpp && ./a.out<cr>   -- 	-- Java   <-- 	autocmd filetype java nnoremap <F4> :w<cr> :!javac %<cr>   B-- 	autocmd filetype java inoremap <F4> <Esc> :w<cr> :!javac %<cr>   -- 	-- Rust   A-- 	autocmd filetype rust nnoremap <F4> :w<cr> :!rustc % && ./%:r   G-- 	autocmd filetype rust inoremap <F4> <Esc> :w<cr> :!rustc % && ./%:r   -- 	-- Python   ?-- 	autocmd filetype python nnoremap <F4> :w<cr> :!python %<cr>   E-- 	autocmd filetype python inoremap <F4> <Esc> :w<cr> :!python %<cr>   -- 	-- Ruby   ;-- 	autocmd filetype ruby nnoremap <F4> :w<cr> :!ruby %<cr>   A-- 	autocmd filetype ruby inoremap <F4> <Esc> :w<cr> :!ruby %<cr>   -- augroup end    5��    �                      &      L              5��