echo "[kubeadmin] master_ip = $1 , k8s_token=$2 ,net_iface=$3 , pod_subnet=$4 , kube_version=$5"
master_ip=$1
k8s_token=$2
net_iface=$3
pod_subnet=$4
kube_version="v$5"

echo "[kubeadmin] Pull google containers from Aliyun"
kubeadm config images pull --kubernetes-version="$kube_version" --image-repository="registry.aliyuncs.com/google_containers">/dev/null 2>&1

echo "[kubeadmin] Initialize Kubernetes Cluster"
kubeadm init --image-repository="registry.aliyuncs.com/google_containers" \
             --apiserver-advertise-address=$master_ip \
             --control-plane-endpoint=$master_ip \
             --kubernetes-version="$kube_version" \
             --token=$k8s_token \
             --pod-network-cidr=$pod_subnet

echo "[kubectl] Set kubectl config"
mkdir -p $HOME/.kube
cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
chown $(id -u):$(id -g) $HOME/.kube/config

echo "[kubectl] Deploy Calico network"
curl -fsSL https://gitee.com/jeff-qiu/k8s-2hours/raw/master/vagrant-all/vagrant-k8s/calico-3.24.5.yaml -o calico.yaml
# 将calico的pod网段设置为kubeadmin初始化的网段，否则网络会有问题
sed -i '/CALICO_IPV4POOL_CIDR/,+1 s/# //' calico.yaml
pod_cidr=$(echo $pod_subnet | sed 's/\//\\\//;s/\./\\\./g')
sed -i "s/192\.168\.0\.0\/16/${pod_cidr}/" calico.yaml
kubectl --kubeconfig=/etc/kubernetes/admin.conf apply -f calico.yaml >/dev/null 2>&1
# 指定calico通信使用的网卡
kubectl --kubeconfig=/etc/kubernetes/admin.conf set env daemonset/calico-node \
        -n kube-system IP_AUTODETECTION_METHOD=interface=$net_iface

echo "***** control-plane initialized complete! *****"