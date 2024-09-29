
# Project: Building Infrastructure with Terraform and Configuring Docker with Ansible

## Objective:
The goal of this project is to build and manage infrastructure across two availability zones (AZs) using Terraform, and configure Docker on private machines using Ansible. The project implements GitOps practices with a CI/CD tool of your choice.

## Tools Required:
- **Terraform**: Used for building the infrastructure.
- **Ansible**: Used for configuration management and automation.
- **Docker**: Installed on private machines to run a container (nginx).
- **GitOps**: Managing configurations and CI/CD processes through a Git repository.
- **CI/CD Tools**: Choose one (Jenkins, GitHub Actions, or GitLab Pipelines).

---

## Architecture Overview

The infrastructure is deployed across two availability zones (AZs) using Terraform. Below is an overview of the key components:

- **VPC**: A Virtual Private Cloud (VPC) is created to host all network resources.
- **Subnets**:
  - Public subnets: Used for internet-facing resources such as the Load Balancer (LB).
  - Private subnets: Hosts EC2 instances for backend services.
- **Auto Scaling Group (ASG)**: Two EC2 instances are deployed into private subnets with automatic scaling policies.
- **Load Balancer (ALB)**: Deployed in the public subnets to distribute incoming traffic to the EC2 instances in the private subnets.
- **Bastion Host**: A Bastion Host is set up in the public subnet to provide secure access to the private instances.

### Terraform Modules Breakdown:

- **VPC Module** (`/terraform/modules/vpc`): 
  - Creates the VPC with CIDR block, internet gateway, and necessary route tables.
  
- **Subnets Module** (`/terraform/modules/subnets`):
  - Handles both public and private subnets in each AZ.

- **EC2 Module** (`/terraform/modules/ec2`):
  - Provisions EC2 instances in the private subnets, managed by an Auto Scaling Group.

- **ALB Module** (`/terraform/modules/alb`):
  - Deploys an Application Load Balancer in the public subnets for handling incoming traffic.

---

## Task Breakdown:

### 1. Terraform Infrastructure Setup:

- **VPC and Networking**: Create a VPC and configure network needs.
- **Subnets**: For each AZ, create two subnets:
  - One public subnet
  - One private subnet
- **Auto Scaling Group (ASG)**: Set up an ASG with two instances.
- **Load Balancer (LB)**: Place the LB in the public subnets.
- **Instances**: Deploy the instances in the private subnets.
- **Inventory**: Ensure the private IPs of the instances are passed to an inventory file for later use by Ansible.

### 2. Bastion Host Configuration:
- Set up a Bastion Host in the public subnet to manage access to the private instances.
- After the infrastructure is created, copy the necessary Ansible role and configuration files to the Bastion Host.

### 3. Ansible Configuration:
- Use Ansible to install Docker on the private instances.
- Create a custom Ansible role for Docker installation.
- Run a **nginx** container on each private instance using Docker.

### 4. GitOps Implementation:
- Manage the entire configuration (Terraform and Ansible) using a Git repository.
- Implement CI/CD pipelines using your chosen tool (Jenkins, GitHub Actions, or GitLab Pipelines) to automate the deployment and configuration process.

---

## Hints:
- You will execute the Ansible playbook on the Bastion Host.
- Ensure that all configurations and scripts are stored and managed in a Git repository.
- Use the inventory file created by Terraform to manage the target hosts for Ansible.

---

## How to Use This Project:
1. **Clone the Repository**:
   ```bash
   git clone <repository-url>
   ```
2. **Run Terraform to Build Infrastructure**:
   ```bash
   cd terraform
   terraform init
   terraform apply -auto-approve
   ```
3. **Set up Bastion Host**:
   - Copy Ansible roles and playbooks to the Bastion Host.
4. **Run Ansible Playbooks**:
   - Use the Terraform-generated inventory file to configure the private instances.
   ```bash
   ansible-playbook -i ansible/inventory/hosts ansible/playbook.yml
   ```
5. **Automate with CI/CD**:
   - Ensure the CI/CD pipeline is set up to automate Terraform and Ansible runs based on repository changes.

## License:
This project is licensed under the MIT License. See the LICENSE file for details.
