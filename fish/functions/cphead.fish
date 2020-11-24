function cphead
    if test -d ./.git -a -e pbcopy
        git l -1 | cut -c 1-7 | pbcopy
    end
end
