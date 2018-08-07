# des3加密
openssl des3 -e -in readme.md -out readme.md.des3

# des3解密
openssl des3 -d -in readme.md.des3 -out readme.md

# 与tar配合
tar zcvf - readme.md | openssl des3 -e > readme.tar.gz.des3
cat readme.tar.gz.des3 | openssl des3 -d | tar xvf -

# 标准命令enc，使用`aes-128-cbc`算法，密码从参数传递
tar cjf package_$commitId.tar.bz2 ./package_$commitId
openssl enc -aes-128-cbc -pass pass:$password \
    -in package_$commitId.tar.bz2 \
    -out package_$commitId.tar.bz2.openssl

# 解密
openssl enc -d -aes-128-cbc \
    -in <in-file> \
    -out <out-file>
