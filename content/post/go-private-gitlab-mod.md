---
title: go mod使用私有仓库
date: 2020-07-28
tags: 
- go
- gitlab
---



```shell
➜  edge-appmgr git:(master) ✗ go get code.private-repo.org/group/edge-appmgr
go: downloading code.private-repo.com/group/edge-appmgr v0.0.0-20200726021754-ace34f1bdac6
go get code.private-repo.com/group/edge-appmgr: code.private-repo.com/group/edge-appmgr@v0.0.0-20200726021754-ace34f1bdac6: verifying module: code.private-repo.com/group/edge-appmgr@v0.0.0-20200726021754-ace34f1bdac6: reading https://sum.golang.org/lookup/code.private-repo.com/group/edge-appmgr@v0.0.0-20200726021754-ace34f1bdac6: 410 Gone
	server response: not found: code.private-repo.com/group/edge-appmgr@v0.0.0-20200726021754-ace34f1bdac6: unrecognized import path "code.private-repo.com/group/edge-appmgr": https fetch: Get "https://code.private-repo.com/group/edge-appmgr?go-get=1": dial tcp: lookup code.private-repo.com on 8.8.8.8:53: no such host
	
➜  edge-appmgr git:(master) ✗ export GOPRIVATE=code.private-repo.com
➜  edge-appmgr git:(master) ✗ go get code.private-repo.com/group/edge-appmgr
go: downloading code.private-repo.com/group/edge-appmgr v0.0.0-20200726021754-ace34f1bdac6
go: code.private-repo.com/group/edge-appmgr upgrade => v0.0.0-20200726021754-ace34f1bdac6
```



```
https://golang.org/doc/faq#git_https

GOPRIVATE

https://github.com/golang/go/issues/35164

/

```



