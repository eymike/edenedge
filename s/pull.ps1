trap [Exception] {
    echo "Error, aborting..."
    exit 1
}


git pull -r


git submodule sync
git submodule update --init --recursive
