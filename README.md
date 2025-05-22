````markdown
# 🚀 Automate Server Setup with Ansible

This project automates the setup of production-ready web servers using **Ansible playbooks**. It configures **Nginx**, **UFW (Uncomplicated Firewall)**, and **Docker** on multiple servers or local VMs. **Terraform** is included to provision AWS infrastructure (e.g., EC2 instances), enabling a complete Infrastructure-as-Code (IaC) workflow.

---

## 📚 Table of Contents

- [Overview](#overview)
- [Prerequisites](#prerequisites)
- [Project Structure](#project-structure)
- [Setup](#setup)
- [Usage](#usage)
- [Ansible Roles](#ansible-roles)
- [Contributing](#contributing)
- [License](#license)

---

## 🧭 Overview

This project streamlines web server configuration using Ansible, ensuring consistent and repeatable deployments. It:

- Installs and configures **Nginx**, **Docker**, and **UFW**
- Manages **user accounts**
- Provisions **AWS EC2** instances using Terraform

### 💡 Ideal For:

- Automating web server deployments  
- Maintaining consistent environments across **dev**, **staging**, and **production**  
- Learning **Infrastructure as Code** with **Ansible** and **Terraform**

---

## ✅ Prerequisites

Make sure the following tools are installed:

- **Ansible**: `v2.9+`  
  📦 `pip install ansible`

- **Terraform**: `v1.5+`  
  📦 [Install Terraform](https://developer.hashicorp.com/terraform/install)

- **AWS CLI**  
  📦 `aws configure` or export credentials:

  ```bash
  export AWS_ACCESS_KEY_ID="your-access-key"
  export AWS_SECRET_ACCESS_KEY="your-secret-key"
````

* **Python 3**
* **Git**
* An **AWS account** with EC2 and security group permissions

---


## 🗂 Project Structure

```
automate-server-ansible/
├── ansible.cfg                  # Ansible configuration
├── group_vars/all.yml           # Shared variables
├── inventory/aws_ec2.yml        # EC2 inventory
├── playbook.yml                 # Main Ansible playbook
├── roles/
│   ├── common/tasks/main.yml    # System updates
│   ├── docker/tasks/main.yml    # Docker install
│   ├── nginx/
│   │   ├── handlers/main.yml
│   │   ├── tasks/main.yml
│   │   └── templates/nginx.conf.j2
│   ├── ufw/tasks/main.yml       # UFW rules
│   └── user/tasks/main.yml      # User setup
├── terraform/
│   ├── main.tf                  # Terraform config
│   ├── outputs.tf
│   ├── variables.tf
│   ├── terraform.tfstate        # State (ignored via .gitignore)
│   └── terraform.tfstate.backup
├── .github/workflows/lint.yml   # GitHub Actions CI
├── .gitignore
├── LICENSE
└── README.md
```

---

## ⚙️ Setup

### 1. Clone the Repository

```bash
git clone https://github.com/reehassan/automate-server-ansible.git
cd automate-server-ansible
```

### 2. Set Up AWS Credentials

```bash
aws configure
# OR
export AWS_ACCESS_KEY_ID="your-access-key"
export AWS_SECRET_ACCESS_KEY="your-secret-key"
```

Ensure your IAM user has permissions for EC2 and security groups.

### 3. Install Tools

```bash
pip install ansible
# Terraform & AWS CLI: Follow official installation guides
```

### 4. Provision AWS Infrastructure

```bash
cd terraform
terraform init
terraform apply
```

> Confirm the plan and note the EC2 public IPs from `terraform output`.

### 5. Configure Ansible Inventory

* Update `inventory/aws_ec2.yml` with EC2 IPs
* Or use the AWS EC2 **dynamic inventory plugin**

### 6. Install Ansible Role Dependencies

```bash
ansible-galaxy install -r requirements.yml
```

---

## 🚀 Usage

### Run the Playbook

```bash
ansible-playbook -i inventory/aws_ec2.yml playbook.yml
```

> Add `-u <username>` or `--private-key <key.pem>` if needed for SSH

---

## ✅ Verify Setup

* **Nginx**:

  ```bash
  curl http://<server-ip>
  ```

* **Docker**:

  ```bash
  ssh <server-ip> docker --version
  ```

* **UFW**:

  ```bash
  ssh <server-ip> sudo ufw status
  ```

---

## 🔄 Teardown (Optional)

```bash
cd terraform
terraform destroy
```

---

## 🧩 Ansible Roles

| Role     | Description                                         |
| -------- | --------------------------------------------------- |
| `common` | Updates system and basic packages                   |
| `docker` | Installs Docker and sets it up                      |
| `nginx`  | Installs and configures Nginx using `nginx.conf.j2` |
| `ufw`    | Configures firewall rules                           |
| `user`   | Adds a user with sudo permissions                   |

Customize each in `roles/<role>/tasks/main.yml`.

---

## 🤝 Contributing

We welcome contributions! Follow these steps:

1. **Fork** the repo
2. **Create a branch**

   ```bash
   git checkout -b feature-name
   ```
3. **Commit changes**

   ```bash
   git commit -m "Add feature-name"
   ```
4. **Push changes**

   ```bash
   git push origin feature-name
   ```
5. **Open a Pull Request**

Follow the project’s style and include tests where appropriate.

---

## 📜 License

This project is licensed under the [MIT License](./LICENSE).

```

---

Let me know if you want badges, diagrams, or if you’d like this saved as a downloadable file.
```
