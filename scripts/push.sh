REPOS=(jpSystemConsole)

if [ $(uname) == Darwin ]; then
    sed() { command sed -l "$@"; }
else
    sed() { command sed -u "$@"; }
fi

# Syntactic sugar.
indent() {
    sed "s/^/       /"
}

puts-msg() {
    echo "    -> $@"
}

# Steps.
puts-step() {
    echo "-----> $@"
}

# Warnings.
puts-warn() {
    echo " !     $@"
}

# Commands.
puts-cmd() {
    echo "     $ $@"
    $@ | indent
}

for repo in ${REPOS[@]}
do
    echo
    puts-step $repo

    cd $repo

    if [ ! -d $repo ]; then
        branch=`git rev-parse --abbrev-ref HEAD`
        msg=`auto commit to branch:`

        puts-msg 'From branch:' $branch
        puts-cmd git add . && \
        git commit -m "$msg$branch" && \
        git push origin $branch
    else
        echo 'else'
    fi

    cd ..
done

branch=`git rev-parse --abbrev-ref HEAD`
msg=`auto commit to branch:`

puts-cmd git add -A
puts-cmd git commit -m "$msg$branch"
puts-cmd git push origin $branch