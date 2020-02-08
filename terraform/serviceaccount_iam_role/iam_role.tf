data "aws_eks_cluster" "cluster-001" {
  name = "${var.eks_cluster_name}"
}

data "aws_caller_identity" "current" {}

### cluster-autoscaler
data "aws_iam_policy_document" "cluster-autoscaler" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
        variable = "${replace(data.aws_eks_cluster.cluster-001.identity[0].oidc[0].issuer, "https://", "")}:sub"
        values   = ["system:serviceaccount:kube-system:cluster-autoscaler"]
    }

    condition {
      test     = "StringEquals"
        variable = "${replace(data.aws_eks_cluster.cluster-001.identity[0].oidc[0].issuer, "https://", "")}:aud"
        values   = ["sts.amazonaws.com"]
    }

    principals {
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/${replace(data.aws_eks_cluster.cluster-001.identity[0].oidc[0].issuer, "https://", "")}"]
      type        = "Federated"
    }
  }
}

resource "aws_iam_role" "cluster-autoscaler" {
  assume_role_policy = data.aws_iam_policy_document.cluster-autoscaler.json
  name               = "cluster-autoscaler"
}

resource "aws_iam_role_policy_attachment" "cluster-autoscaler" {
  role       = aws_iam_role.cluster-autoscaler.name
  policy_arn = aws_iam_policy.cluster-autoscaler.arn
}

### external-dns
data "aws_iam_policy_document" "external-dns" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
        variable = "${replace(data.aws_eks_cluster.cluster-001.identity[0].oidc[0].issuer, "https://", "")}:sub"
        values   = ["system:serviceaccount:kube-system:external-dns"]
    }

    condition {
      test     = "StringEquals"
        variable = "${replace(data.aws_eks_cluster.cluster-001.identity[0].oidc[0].issuer, "https://", "")}:aud"
        values   = ["sts.amazonaws.com"]
    }

    principals {
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/${replace(data.aws_eks_cluster.cluster-001.identity[0].oidc[0].issuer, "https://", "")}"]
      type        = "Federated"
    }
  }
}

resource "aws_iam_role" "external-dns" {
  assume_role_policy = data.aws_iam_policy_document.external-dns.json
  name               = "external-dns"
}

resource "aws_iam_role_policy_attachment" "external-dns" {
  role       = aws_iam_role.external-dns.name
  policy_arn = aws_iam_policy.external-dns.arn
}

### alb-ingress-controller
data "aws_iam_policy_document" "alb-ingress-controller" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
        variable = "${replace(data.aws_eks_cluster.cluster-001.identity[0].oidc[0].issuer, "https://", "")}:sub"
        values   = ["system:serviceaccount:kube-system:alb-ingress-controller"]
    }

    condition {
      test     = "StringEquals"
        variable = "${replace(data.aws_eks_cluster.cluster-001.identity[0].oidc[0].issuer, "https://", "")}:aud"
        values   = ["sts.amazonaws.com"]
    }

    principals {
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/${replace(data.aws_eks_cluster.cluster-001.identity[0].oidc[0].issuer, "https://", "")}"]
      type        = "Federated"
    }
  }
}

resource "aws_iam_role" "alb-ingress-controller" {
  assume_role_policy = data.aws_iam_policy_document.alb-ingress-controller.json
  name               = "alb-ingress-controller"
}

resource "aws_iam_role_policy_attachment" "alb-ingress-controller" {
  role       = aws_iam_role.alb-ingress-controller.name
  policy_arn = aws_iam_policy.alb-ingress-controller.arn
}

### ExternalSecrets
data "aws_iam_policy_document" "external-secrets" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
        variable = "${replace(data.aws_eks_cluster.cluster-001.identity[0].oidc[0].issuer, "https://", "")}:sub"
        values   = ["system:serviceaccount:kube-system:external-secrets"]
    }

    condition {
      test     = "StringEquals"
        variable = "${replace(data.aws_eks_cluster.cluster-001.identity[0].oidc[0].issuer, "https://", "")}:aud"
        values   = ["sts.amazonaws.com"]
    }

    principals {
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/${replace(data.aws_eks_cluster.cluster-001.identity[0].oidc[0].issuer, "https://", "")}"]
      type        = "Federated"
    }
  }
}

resource "aws_iam_role" "external-secrets" {
  assume_role_policy = data.aws_iam_policy_document.external-secrets.json
  name               = "external-secrets"
}

resource "aws_iam_role_policy_attachment" "external-secrets" {
  role       = aws_iam_role.external-secrets.name
  policy_arn = aws_iam_policy.external-secrets.arn
}
