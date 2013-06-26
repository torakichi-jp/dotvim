# dotvim

This is my vim setting files.

http://github.com/torakichi-jp/dotvim

#インストール

##Vim本体のインストール
*参考
http://vim-jp.org/


#プラグインのインストール

まずNeoBundle(http://github.com/Shougo/neobundle)とVimProc
(http://github.com/Shougo/vimproc)をダウンロードして,dotvim/vimfiles/bundleに
展開する。
その後、次のコマンドでNeoBundleとVimProcをインストールする（NeoBundleの
buildオプションにより、VimProcは自動でビルドされる。ただし、WindowsでVisual
Studioを入れていない場合は手動でビルドする必要がある）。

    vim -u NONE

あとはVimを普通に起動して、Install Bundles ? に Yes と答えれば各プラグインがイ
ンストールされる

