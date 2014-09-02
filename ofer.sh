clear
exec 2> >( tee /tmp/err )
set -o nounset
trap trap_err ERR
print_color(){
print_color_n $@
echo
}

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
  source $file_config
  type step1
}


print_line(){
  echo 1>&2 --------
}

intro_start(){
  cat1 $file_list
}
cat1(){
  local file=$1
  echo "[ $file ] "
  echo -----------
  cat -n $file 
  echo -----------
}

print_color_n () 
{ 
  if [ $# -gt 1 ]; then
    local color=$1;
    shift;
    local args="${@:-}";
    echo -en "\x1B[01;${color}m[*]\x1B[0m ${args} " 1>&2;
  fi
}
indicator(){
  local num=$1
  if [ $num -ne 0 ];then
    print_color_n 31 ''
    #[x]'
  else
    print_color_n 32 ''
    #[v]'
  fi
  echo 1>&2
}


exiting(){
  print_color 33 exiting
  
  $str_caller
  exit 0
}
commander(){
  set -e
  local args=( $@ )
  local cmd="${args[@]}"
  local res=1
  echo -----------
  print_color_n  33  "[CMD] $cmd"
  #    echo "$cmd" | pv -qL 10
  sleep 1
  eval "$cmd" 1>/tmp/out 2>/tmp/err || { cat1 /tmp/err; exiting; }
  res=$?
  indicator "$res"
}




ensure_depend(){
  #    sudo apt-get install pv
  #    apt-get source dh-make-php
  #    apt-get source libssh2-php
  cmd='sudo apt-get install'
  while read line;do
    ( exec &>/dev/null; dpkg -L $line ) || ( print_color 33 'Installing missing dependencies'; eval "$cmd $line";  ) 
  done <$file_depend

}

trap_err(){
  echo  "[ $FUNCNAME ]"
  $str_caller
  cat /tmp/err
  exit 0
}


url(){
  http://www.dotdeb.org/2008/09/25/how-to-package-php-extensions-by-yourself/ 
  https://extremeshok.com/5280/ubuntu-debian-install-php-ssh2-php-ssh-extension/

  echo 'Install PHP-SSH2 ( php-ssh ) extension'
  echo Install Build Dependancies
  apt-get install libssh2-1 libssh2-1-dev
  echo Download ssh2 files
  cd /tmp
  wget http://pecl.php.net/get/ssh2-0.12.tgz
  tar -zxvf ssh2-0.12.tgz
  echo Compile and Install
  cd ssh2-0.12
  phpize
  ./configure --with-ssh2
  make && make install
  Configure php-ssh2
  echo -e "\n\n[php-ssh2]\n;http://pecl.php.net/package/ssh2\nextension=ssh2.so\n\n" >> /etc/php5/mods-available/ssh2.ini
  echo Enable php-ssh2
  ln -s /etc/php5/mods-available/ssh2.ini /etc/php5/conf.d/20-ssh2.ini
  echo Restart PHP5-fpm to apply the config
  service php5-fpm restart


}
stepper(){
  while read line;do
    [ -n "$line" ] || { print_color_n 34 "\n\nempty line.." ; exiting; }
    commander $(eval echo $line) 
   # || exiting
  done< $file_list
  # pecl search ssh2 
}

show_funcs(){
  echo Options:
  echo  =-=-=-=-=--
  nl < <( cat $0 | grep '(){' | grep -v grep | sed 's/(){//g' )
}

steps(){
  set_env
  ensure_depend
  intro_start
  stepper
}

dir_self=`where_am_i $0`

mkdir -p /tmp/1
pushd /tmp/1  >/dev/null

#str_caller='$(caller)'
str_caller='eval echo $(caller)'

${1:-steps}

popd >/dev/null
