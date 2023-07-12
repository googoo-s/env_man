# 单台服务器


## 文件同步

* 安装插件
  ```
  vagrant plugin install vagrant-vbguest
  ```

* 配置
  ```
  Vagrant.configure("2") do |config|
    config.vm.box = "centos/7"
    # config.vm.box_url = "https://mirrors.ustc.edu.cn/centos-cloud/centos/7/vagrant/x86_64/images/CentOS-7.box"
    config.vm.box_version = "2004.01"
    config.vm.hostname = "centos7"
    config.vbguest.installer_options = { allow_kernel_upgrade: true }
    # 使用公共的ssh 私钥
    config.ssh.insert_key = false
    # 将启用 vagrant-vbguest 插件的自动更新功能
    # config.vbguest.auto_update = true
    # 同步文件夹
    config.vm.synced_folder ".", "/v"
  end
  ```  