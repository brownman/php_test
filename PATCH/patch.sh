#https://linuxacademy.com/blog/linux/introduction-using-diff-and-patch/

#http://www.cyberciti.biz/faq/appy-patch-file-using-patch-command/
$cmd_trap_err
$cmd_trap_exit


set_env(){
    dir_self=.
    file_old=/tmp/hello
    file_new=/tmp/hello_world
    file_upgraded=/tmp/upgraded

    patch=/tmp/hello.patch
    cmd_patch="patch -p0 < $patch"
    cmd_patch_revert="patch -Rp0 < $patch"
    cmd_wana_be="patch $file_old -i $patch  -o $file_upgraded"
}

prepare_diff(){
    #set +e
    #trap - ERR
    local     cmd1='diff -u'
    local     cmd2='diff -c'
    local    cmd="$cmd1"
    ( set +e; commander "$cmd $file_old $file_new > $patch" )
    echo bye
    
}

patch_apply(){
    ( commander $cmd_wana_be )
    commander $cmd_patch
}
intro(){
    echo The hello.patch patchfile knows the name of the file to be patched ##
    echo
    cat1 $dir_self/PATCH/INFO/level.txt
    cat1 $dir_self/PATCH/INFO/dir_diff.txt
}

patch_revert(){
    commander $cmd_patch_revert
}


before_all(){
    echo hello > $file_old
    echo hello_world > $file_new
    echo -n '' > $file_upgraded
}
cat2(){
    echo -ne "$1 ] \t"
    echo "`cat $1`"
}
show_patch(){
    cat1 $patch
}
show(){
    #cat1 $patch
    cat2 $file_old
    cat2 $file_new
    cat2 $file_upgraded

}
step(){
    figlet $@
    commander1 $@
}

steps(){
    clear
    set -u
    #set -e
    source helper.cfg
        #set -x

    set -i
    set_env

    intro
    sleep 4
    step before_all
    show
    step prepare_diff
    show_patch
    (     step patch_apply )
    show

    step patch_revert
    show
    print_color 31 the end


}
set +u
echo
(steps)
echo
