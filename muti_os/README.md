# 多台服务器


## 全局配置
```
  ##
  ## 全局的配置
  ##
  config.vm.box = "centos/7"
  config.vm.box_url = "https://mirrors.ustc.edu.cn/centos-cloud/centos/7/vagrant/x86_64/images/CentOS-7.box"
  config.vm.hostname = "centos7"
  # 使用公共的ssh 私钥
  config.ssh.insert_key = false

  # 定义两台机器
  config.vm.define "vm1"
  config.vm.define "vm2"
```
## 局部配置

```
  ##
  ## 全局的配置
  ##
  config.vm.box = "centos/7"
  config.vm.box_url = "https://mirrors.ustc.edu.cn/centos-cloud/centos/7/vagrant/x86_64/images/CentOS-7.box"
  # 使用公共的ssh 私钥
  config.ssh.insert_key = false

  # 定义两台机器
  config.vm.define "vm1" do |vm1|
      vm1.vm.hostname = "vm1"
  end
  config.vm.define "vm2"  do |vm2|
      vm2.vm.hostname = "vm2"
  end 
```


## 批量创建虚拟机

```

```