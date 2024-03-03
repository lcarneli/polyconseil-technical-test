resource "aws_iam_role" "eks_cluster" {
  name = "${var.customer_name}-${var.project_name}-eks-cluster"

  assume_role_policy = <<POLICY
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Service": "eks.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
      }
    ]
  }
  POLICY

  tags = {
    "Name" = "${var.customer_name}-${var.project_name}-eks-cluster"
  }
}

resource "aws_iam_role_policy_attachment" "eks_cluster" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster.name
}

resource "aws_eks_cluster" "main" {
  name     = "${var.customer_name}-${var.project_name}"
  version  = var.cluster_version
  role_arn = aws_iam_role.eks_cluster.arn

  vpc_config {
    subnet_ids              = var.cluster_subnet_ids
    endpoint_public_access  = true
    public_access_cidrs     = var.cluster_public_access_cidrs
    endpoint_private_access = true
  }

  tags = {
    "Name" = "${var.customer_name}-${var.project_name}"
  }

  depends_on = [aws_iam_role_policy_attachment.eks_cluster]
}

resource "aws_iam_role" "eks_nodes" {
  name = "${var.customer_name}-${var.project_name}-eks-nodes"

  assume_role_policy = <<POLICY
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Service": "ec2.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
      }
    ]
  }
  POLICY

  tags = {
    "Name" = "${var.customer_name}-${var.project_name}-eks-nodes"
  }
}

resource "aws_iam_role_policy_attachment" "eks_worker_node" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks_nodes.name
}

resource "aws_iam_role_policy_attachment" "eks_cni" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks_nodes.name
}

resource "aws_iam_role_policy_attachment" "ec2_container_registry_read_only" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks_nodes.name
}

resource "aws_iam_role_policy_attachment" "ebs_csi_driver" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
  role       = aws_iam_role.eks_nodes.name
}

resource "aws_eks_addon" "ebs_csi_driver" {
  addon_name    = "aws-ebs-csi-driver"
  addon_version = var.ebs_csi_driver_version
  cluster_name  = aws_eks_cluster.main.id
}

resource "aws_eks_node_group" "main" {
  cluster_name    = aws_eks_cluster.main.name
  node_group_name = "${var.customer_name}-${var.project_name}"
  node_role_arn   = aws_iam_role.eks_nodes.arn
  subnet_ids      = var.node_group_subnet_ids

  ami_type       = var.node_group_ami_type
  capacity_type  = var.node_group_capacity_type
  instance_types = var.node_group_instance_types
  disk_size      = var.node_group_disk_size

  scaling_config {
    desired_size = var.node_group_desired_size
    max_size     = var.node_group_max_size
    min_size     = var.node_group_min_size
  }

  tags = {
    "Name" = "${var.customer_name}-${var.project_name}"
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_worker_node,
    aws_iam_role_policy_attachment.eks_cni,
    aws_iam_role_policy_attachment.ec2_container_registry_read_only,
    aws_iam_role_policy_attachment.ebs_csi_driver
  ]
}