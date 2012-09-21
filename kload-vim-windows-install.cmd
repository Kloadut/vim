@if not exist "%HOME%" @set HOME=%HOMEDRIVE%%HOMEPATH%
@if not exist "%HOME%" @set HOME=%USERPROFILE%

@set BASE_DIR=%HOME%\.kload-vim
call git clone --recursive -b 3.0 git://github.com/spf13/kload-vim.git 
%BASE_DIR%
call mkdir %BASE_DIR%\.vim\bundle
call mklink /J %HOME%\.vim %BASE_DIR%\.vim
call mklink %HOME%\.vimrc %BASE_DIR%\.vimrc
call mklink %HOME%\_vimrc %BASE_DIR%\.vimrc

call git clone http://github.com/gmarik/vundle.git %HOME%/.vim/bundle/vundle
