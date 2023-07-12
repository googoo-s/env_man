#!/bin/bash
echo "[TASK 1] Disable and turn off SWAP"
sed -i '/swap/d' /etc/fstab
swapoff -a

echo "[TASK 2] Stop and Disable firewall"
systemctl disable --now ufw >/dev/null 2>&1

echo "[TASK 3] Enable and Load Kernel modules"
cat >>/etc/modules-load.d/containerd.conf<<EOF
overlay
br_netfilter
EOF
modprobe overlay
modprobe br_netfilter

echo "[TASK 4] Add Kernel settings"
cat >>/etc/sysctl.d/kubernetes.conf<<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables  = 1
net.ipv4.ip_forward                 = 1
EOF
sysctl --system >/dev/null 2>&1

echo "[TASK 5] Enable ssh password authentication"
sed -i 's/^PasswordAuthentication .*/PasswordAuthentication yes/' /etc/ssh/sshd_config
echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config
systemctl reload sshd

echo "[TASK 6] Set root password"
echo -e "123456\n123456" | passwd root >/dev/null 2>&1
echo "export TERM=xterm" >> /etc/bash.bashrc

echo "[TASK 7] Add Aliyun kubernetes repo"
sudo curl -s http://mirrors.aliyun.com/kubernetes/apt/doc/apt-key.gpg | gpg --dearmor > /etc/apt/keyrings/kubernetes-archive-keyring.gpg
cat > /etc/apt/sources.list.d/kubernetes.list<<EOF
deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://mirrors.aliyun.com/kubernetes/apt/ kubernetes-xenial main
EOF

echo "[TASK 8] Install containerd runtime"
# kubernete 1.26 需要安装containerd 1.6+ 
# ubuntu仓库里的containerd版本较低，因此使用docker仓库安装containerd
curl -fsSL https://mirrors.aliyun.com/docker-ce/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://mirrors.aliyun.com/docker-ce/linux/ubuntu $(lsb_release -cs) stable" |\
      tee /etc/apt/sources.list.d/docker.list > /dev/null 2>&1
apt-get update -qq && apt-get install -y containerd.io >/dev/null 2>&1
containerd config default > /etc/containerd/config.toml
# 使用systemd作为cgroup驱动
sed -i 's/SystemdCgroup \= false/SystemdCgroup \= true/g' /etc/containerd/config.toml
systemctl enable containerd --now >/dev/null 2>&1

echo "[TASK 9] Add Aliyun registry mirror to containerd config.toml"
# 重新设置containerd的sandbox_image
# containerd沙箱镜像默认使用registry.k8s.io/pause,由于registry.k8s.io无法访问,因此可能导致kubernetes安装失败
# 注意：从1.25版本开始，google的镜像中心由原来的k8s.gcr.io变更为registry.k8s.io
sed -i 's/registry.k8s.io\/pause/registry.aliyuncs.com\/google_containers\/pause/g' /etc/containerd/config.toml
sed -i 's/k8s.gcr.io\/pause/registry.aliyuncs.com\/google_containers\/pause/g' /etc/containerd/config.toml
cat >>/etc/containerd/config.toml<<EOF
# containerd访问dockerHub使用阿里云镜像加速
[plugins."io.containerd.grpc.v1.cri".registry.mirrors."docker.io"]
  endpoint = ["https://fsp2sfpr.mirror.aliyuncs.com/"]
EOF
systemctl restart containerd

echo "[TASK 10] Install Kubernetes components (kubeadm, kubelet and kubectl) version $1"
version="${1}-00"
apt-get update -qq && apt-get install -y kubeadm="$version" kubelet="$version" kubectl="$version" >/dev/null 2>&1