#https://linuxacademy.com/blog/linux/introduction-using-diff-and-patch/
#http://www.cyberciti.biz/faq/appy-patch-file-using-patch-command/

set_env(){
    file_old=/tmp/hello
    file_new=/tmp/hello_world
    file_old_upgraded=/tmp/2_new

    patch=/tmp/hello.patch
}

prepare_diff(){
    set +e
    trap - ERR
local     cmd1='diff -u'
local     cmd2='diff -c'
local    cmd="$cmd1"
commander "$cmd $file_old $file_new > $patch"

}

patch_apply(){

#    patch < hello.patch

    patch $file_old -i $patch  -o $file_old_upgraded

}
intro(){
    echo The hello.patch patchfile knows the name of the file to be patched ##
}

patch_reverse(){
    patch $file_old_upgraded -i 
}


before_all(){
    echo hello > $file_old
    echo hello_world > $file_new
    echo -n '' > $file_old_upgraded
}
show(){
    cat1 $patch
    cat1 $file_old
    cat1 $file_new
    cat1 $file_old_upgraded
}

steps(){
clear
set -u
#set -e
source helper.cfg
#$cmd_trap_err
$cmd_trap_exit


    #set -x
    set -i
    set_env
commander1    before_all
    show
    intro
commander1    prepare_diff
    show
commander1    patch_apply
    show
    
  commander1   patch_reverse
    show
    print_color 31 the end


}
set +u
echo
(steps)
echo
