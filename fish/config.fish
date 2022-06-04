if test -r /opt/homebrew
  set -gx LDFLAGS "-L/opt/homebrew/opt/node@16/lib"
  set -gx CPPFLAGS "-I/opt/homebrew/opt/node@16/include"
  fish_add_path -U /opt/homebrew/bin
  fish_add_path -U /opt/homebrew/opt/node@16/bin
end

if test -r /usr/local/Homebrew
  set -gx LDFLAGS "-L/usr/local/opt/node@16/lib"
  set -gx CPPFLAGS "-I/usr/local/opt/node@16/include"
  fish_add_path /usr/local/opt/node@16/bin
end

set -gx JAVA_HOME /Library/Java/JavaVirtualMachines/jdk1.8.0_331.jdk/Contents/Home


fish_vi_key_bindings

for mode in insert default visual
  bind -M $mode \cf forward-char
end
