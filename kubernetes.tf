data "aws_iam_role" "eks-sa" {
  name = "eks-sa"
}

# Создание EKS кластера
resource "aws_eks_cluster" "eks_cluster" {
  name     = "lab-dev-k8s"
  role_arn = data.aws_iam_role.eks-sa.arn
  version  = "1.31"

  vpc_config {
    security_group_ids = [ aws_security_group.lab-default.id ]
    subnet_ids = [
      aws_subnet.lab-dev-a.id,
      aws_subnet.lab-dev-b.id,
      aws_subnet.lab-dev-c.id
    ]

    endpoint_private_access = true
    endpoint_public_access  = false
  }
  enabled_cluster_log_types = [ ]
  bootstrap_self_managed_addons = false

  zonal_shift_config {
    enabled = false
  }
  upgrade_policy {
    support_type = "STANDARD"
  }
  kubernetes_network_config {
    service_ipv4_cidr = "172.16.0.0/16"
    ip_family = "ipv4"
  }
}

/*
# Создание группы узлов (Node Group)
resource "aws_eks_node_group" "eks_node_group" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = "${var.cluster_name}-node-group"
  node_role_arn   = aws_iam_role.eks_node_role.arn
  subnet_ids      = [for subnet in aws_subnet.private_subnets : subnet.id]

  scaling_config {
    desired_size = var.desired_capacity
    max_size     = var.max_size
    min_size     = var.min_size
  }

  instance_types = [var.node_instance_type]

  remote_access {
    ec2_ssh_key = "your-ssh-key"  # Укажите ваш SSH ключ или удалите блок, если не нужен доступ по SSH
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_worker_node_policy,
    aws_iam_role_policy_attachment.eks_cni_policy,
    aws_iam_role_policy_attachment.ec2_container_registry_read_only
  ]
}

# Установка аддонов CoreDNS и kube-proxy
resource "aws_eks_addon" "coredns" {
  cluster_name = aws_eks_cluster.eks_cluster.name
  addon_name   = "coredns"
}

resource "aws_eks_addon" "kube_proxy" {
  cluster_name = aws_eks_cluster.eks_cluster.name
  addon_name   = "kube-proxy"
}

# Получение конфигурации kubeconfig
resource "local_file" "kubeconfig" {
  content  = aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer
  filename = "${path.module}/kubeconfig_${var.cluster_name}"
}
*/