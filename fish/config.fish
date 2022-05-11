if test -f /opt/homebrew
  set -gx LDFLAGS "-L/opt/homebrew/opt/node@16/lib"
  set -gx CPPFLAGS "-I/opt/homebrew/opt/node@16/include"
  fish_add_path -U /opt/homebrew/bin
  fish_add_path -U /opt/homebrew/opt/node@16/bin
end

fish_vi_key_bindings

for mode in insert default visual
  bind -M $mode \cf forward-char
end
