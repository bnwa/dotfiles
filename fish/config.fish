set -l hasJava (ls /Library/Java/JavaVirtualMachines 2> /dev/null)
set -l hasPython (ls ~/Library/Python 2> /dev/null)

if [ $hasJava ]
  set -g JAVA_HOME /Library/Java/JavaVirtualMachines/jdk1.8.0_261.jdk/Contents/Home
  set -g PATH $JAVA_HOME/bin $PATH
end

if [ $hasPython ] && test -d /Library/Python/"$hasPython[1]"/bin
  set -g PATH ~/Library/Python/3.8/bin $PATH
end

fish_vi_key_bindings

for mode in insert default visual
  bind -M $mode \cf forward-char
end
