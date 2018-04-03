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

    if [ ! -d $repo ]; then
        # Clone the repository
        puts-cmd git clone https://github.com/mhigley/$repo.git $repo
        cd $repo
    else
        # Pull the latest from the current branch
        cd $repo
        branch=`git rev-parse --abbrev-ref HEAD`
        puts-cmd git fetch
        puts-cmd git pull origin $branch
    fi

    cd ..
done