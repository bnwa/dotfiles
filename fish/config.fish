set -l SYS_JAVA /Library/Java/JavaVirtualMachines
set -l USER_PYTHON ~/Library/Python

set -l hasJava (ls $SYS_JAVA 2> /dev/null)
set -l hasPython (ls USER_PYTHON 2> /dev/null)

if [ "$hasJava" ]
  set -gx JAVA_HOME /Library/Java/JavaVirtualMachines/jdk1.8.0_261.jdk/Contents/Home
  set -gx PATH $JAVA_HOME/bin $PATH
end

if [ "$hasPython" ]
  set -gx PATH ~/Library/Python/3.8/bin $PATH
end

fish_vi_key_bindings

for mode in insert default visual
  bind -M $mode \cf forward-char
end
