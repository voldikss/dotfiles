# vim:ft=bash
# 简单的自定义命令

docker_find_child_images_by_parent_id() {
    if [[ $1 == "h" || $1 == "help" ]]; then
        echo "列出所有在指定 image 之后创建的 image 的父 image"
        return 0
    fi
    if [[ $1 == "" ]]; then
        echo "Usage: docker_find_child_images_by_parent_id <image id>"
        return 0
    fi
    docker image inspect --format='{{.RepoTags}} {{.Id}} {{.Parent}}' $(docker image ls -q --filter since=$1)
}

npm_publish_to_local_nexus() {
    local current_dir=`pwd`
    if [[ -n $1 ]]; then
        local target_dir=`pwd`/$1
        cd $target_dir
    fi
    cp package.json package.json.bak
    sed -i 's@"registry": ".*"$@"registry": "http://localhost:8081/repository/npm-private"@g' package.json
    sleep 0.5s
    npm publish
    sleep 0.5s
    cp package.json.bak package.json
    rm package.json.bak
    cd $current_dir
}

withproxy() {
    HTTPS_PROXY=http://127.0.0.1:1081 HTTP_PROXY=http://127.0.0.1:1081 ALL_PROXY=socks5://127.0.0.1:1081 $@
}

