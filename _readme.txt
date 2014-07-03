symbolic link to .vim .vimrc .gvimrc files so they can be posted to bit bucket

ran:

ln -s ~/.vim ~/git/vim/vim 
ln -s ~/.vimrc ~/git/vim/vimrc 
ln -s ~/.gvimrc ~/git/vim/gvimrc 

echo "_readme.txt" > .gitignore
git init
git add .
git commit
git push origin master



