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
    echo
    cd jpSystemConsole
    remote=`git config --get remote.origin.url`
    puts-msg $remote
    cd ..
    
    if [ ! -d $repo ] || [ $remote == 'https://github.com/mhigley/jp-dev.git' ]; then
        # Clone the repository
        puts-cmd git clone https://github.com/mhigley/$repo.git $repo
    else
        # Pull the latest from the current branch
        cd $repo
        branch=`git rev-parse --abbrev-ref HEAD`
        puts-cmd git fetch
        puts-cmd git pull origin $branch
        puts-warn else-block
    fi

    cd ..
done