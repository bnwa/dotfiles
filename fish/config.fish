if test -d /opt/homebrew
  set -gx LDFLAGS "-L/opt/homebrew/opt/node@16/lib"
  set -gx CPPFLAGS "-I/opt/homebrew/opt/node@16/include"
  fish_add_path -U /opt/homebrew/bin
  fish_add_path -U /opt/homebrew/opt/node@16/bin
end

if test -d /usr/local/Homebrew
  set -gx LDFLAGS "-L/usr/local/opt/node@16/lib"
  set -gx CPPFLAGS "-I/usr/local/opt/node@16/include"
  fish_add_path /usr/local/opt/node@16/bin
end


fish_vi_key_bindings

for mode in insert default visual
  bind -M $mode \cf forward-char
end
