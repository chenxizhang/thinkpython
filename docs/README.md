# 如何使用这个模板
> 陈希章 2023-1-6

1. 修改 `gitbook.yml` 中的域名信息, 只要修改 youbookname 为你的书籍简写就可以了，这个域名映射已经用通配符做好了。
    
    cname: **youbookname**.book.xizhang.com

1. 在仓库的设置中，启用 `https`，因为新式浏览器可能只支持 https。 这个步骤是可选的。
1. 修改 book.json 文件中的必要信息。
1. 编写文档，在 `docs` 目录中， `SUMMARY.md` 是目录文件， 可以自己随意定义目录结构，指向对应的文件。
1. 如果需要在本地生成pdf文件，请确保电脑上安装了 `calibre` 这个软件 （<https://calibre-ebook.com/download>），然后在命令行运行 `yarn run pdf` 即可。
