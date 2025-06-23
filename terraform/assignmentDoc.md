Here's a structured guide and breakdown to help you complete the assignment:

---

## ✅ **Assignment Goal:**

Provision an AWS infrastructure using Terraform, including:

* **VPC** (Networking)
* **EKS** (Kubernetes cluster)
* **ECS** (Container service)
* **S3** (Object storage)
* **RDS** (Managed database)

---

## 📁 Recommended Project Structure:

```
aws-infra/
├── main.tf
├── variables.tf
├── outputs.tf
├── provider.tf
├── terraform.tfvars
├── modules/
│   ├── vpc/
│   ├── eks/
│   ├── ecs/
│   ├── rds/
│   └── s3/
```

---

## 🧱 Step-by-Step Module Overview

### 🔹 1. **VPC Module**

Create networking infrastructure used by all other components.

**Resources:**

* `aws_vpc`
* `aws_subnet`
* `aws_internet_gateway`
* `aws_nat_gateway`
* `aws_route_table`

---

### 🔹 2. **EKS Module**

Provision a Kubernetes cluster on AWS.

**Resources:**

* `aws_eks_cluster`
* `aws_eks_node_group`
* IAM roles for EKS

Use the [official EKS module](https://registry.terraform.io/modules/terraform-aws-modules/eks/aws/latest) for simplicity:

```hcl
module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = var.cluster_name
  subnets         = module.vpc.public_subnets
  vpc_id          = module.vpc.vpc_id
  node_groups     = {
    default = {
      desired_capacity = 2
      max_capacity     = 3
      instance_types   = ["t3.medium"]
    }
  }
}
```

---

### 🔹 3. **ECS Module**

Provision an ECS Cluster using EC2 or Fargate.

**Resources:**

* `aws_ecs_cluster`
* `aws_ecs_service`
* `aws_ecs_task_definition`
* `aws_launch_configuration` (if EC2-backed)

---

### 🔹 4. **RDS Module**

Provision a managed PostgreSQL/MySQL database.

**Resources:**

* `aws_db_instance`
* Subnet group and security groups

**Example:**

```hcl
resource "aws_db_instance" "default" {
  identifier        = "mydb"
  engine            = "postgres"
  instance_class    = "db.t3.micro"
  allocated_storage = 20
  username          = var.db_user
  password          = var.db_password
  skip_final_snapshot = true
  vpc_security_group_ids = [module.vpc.db_sg]
}
```

---

### 🔹 5. **S3 Module**

Provision one or more S3 buckets.

**Resources:**

* `aws_s3_bucket`
* `aws_s3_bucket_public_access_block`
* Versioning, encryption as needed

**Example:**

```hcl
resource "aws_s3_bucket" "storage" {
  bucket = "my-app-storage-${var.env}"
  acl    = "private"

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}
```

---

## 📦 Common Variables (`variables.tf`)

```hcl
variable "region" { default = "us-west-2" }
variable "env"    { default = "dev" }

variable "db_user" {}
variable "db_password" {
  sensitive = true
}
```

---

## 📤 Outputs (`outputs.tf`)

```hcl
output "eks_cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "rds_endpoint" {
  value = aws_db_instance.default.endpoint
}
```

---

## 🚀 Deployment Commands

```bash
terraform init
terraform plan -out=tfplan
terraform apply tfplan
```

---

## 🔐 Security & Best Practices

* Use **Terraform Cloud** or an **S3 + DynamoDB** backend.
* Store secrets (DB passwords) securely, ideally using `terraform.tfvars` or `secrets.auto.tfvars`.
* Use **remote modules** where possible.
* Add `terraform test` or `tfsec` for validation/security scanning.

---

## 🧪 Optional Enhancements

* Configure **ALB** and **Ingress** for EKS or ECS.
* Add **CloudWatch monitoring/logs**.
* Configure **autoscaling** for ECS/EKS nodes.
* Add **IAM roles** with least privilege for EKS/ECS services.

---

Would you like me to generate a **starter project template** with all the modules and example configurations in a zip, or paste the full code here?
