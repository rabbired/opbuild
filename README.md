# add binwalk tools
see https://github.com/ReFirmLabs/binwalk
# 用于编译Lean源码的简易容器
    # 生成命令
    sudo bash -c cat > '/etc/profile.d/opbuild.sh' <<EOF
    #!/bin/bash
    alias opmake="docker run -it --rm -v $OPDIR:/opt/opbuild rabbired/opbuild bash "
    EOF
    
    # 重新载入环境变量
    source /etc/profile
    
    # 固件工具使用方法
    docker exec [容器名] binwalk or /usr/local/bin/binwalk
