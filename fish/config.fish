fish_add_path /usr/local/opt/node@14/bin

fish_vi_key_bindings

for mode in insert default visual
  bind -M $mode \cf forward-char
end
