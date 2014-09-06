#  http://www.dotdeb.org/2008/09/25/how-to-package-php-extensions-by-yourself/ 
#  https://extremeshok.com/5280/ubuntu-debian-install-php-ssh2-php-ssh-extension/

clear

exec 2> >( tee /tmp/err )
set -o nounset
#set -e
trap trap_err ERR



where_am_i () 
{ 
  local file=${1:-"${BASH_SOURCE[1]}"};
  local rpath=$(readlink -m $file);
  local rcommand=${rpath##*/};
  local str_res=${rpath%/*};
  local dir_self="$( cd $str_res  && pwd )";
  echo "$dir_self"
}


set_env(){
  export file_list="$dir_self/list.sh"
  export file_depend="$dir_self/depend.txt"
  export file_config="$dir_self/config.cfg"
  export file_helper="$dir_self/helper.cfg"

  source $file_config
  source $file_helper
  set_package_details
}

intro_start(){
env
arch
cat1 $file_list
}



ensure_depend(){
  #    sudo apt-get install pv
  #    apt-get source dh-make-php
  #    apt-get source libssh2-php
  cmd='sudo apt-get install'
  while read line;do
      [ -n "$line" ] || { echo returning;  return; }
    ( exec &>/dev/null; dpkg -L $line ) || ( print_color 33 'Installing missing dependencies'; eval "$cmd $line";  ) 
  done <$file_depend

}

trap_err(){
  echo  "[ $FUNCNAME ]"
  $str_caller
  cat /tmp/err
  exit 
}


stepper(){
  while read line;do
    [ -n "$line" ] || { print_color_n 34 "\n\nempty line.." ; break; }
     set -e; commander1 "$(eval echo $line)"  || break
    #|| { print error; exiting; } 
    # || exiting
  done< $file_list
  # pecl search ssh2 
}




steps(){
  set_env
  ensure_depend
  intro_start
  (   stepper )
  echo
}

dir_self=`where_am_i $0`

mkdir -p /tmp/1
#pushd /tmp/1  >/dev/null
dir_parent=/tmp/1
#str_caller='$(caller)'
str_caller='eval echo $(caller)'

cmd_start=${1:-steps}
$cmd_start
#cleanup_tmp
#popd >/dev/null
