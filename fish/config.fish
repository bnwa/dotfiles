if test -f /opt/homebrew;
  fish_add_path /opt/homebrew/bin
end

fish_vi_key_bindings

for mode in insert default visual
  bind -M $mode \cf forward-char
end

set -xU nvm_default_version lts/gallium
