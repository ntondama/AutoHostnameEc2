# 🚀 Auto Hostname EC2 with Terraform

This project automates the creation of an EC2 instance in AWS using Terraform, and automatically sets the hostname of the instance based on the name tag defined in the configuration.

---

## 📦 What It Does

- Creates a custom VPC and subnet.
- Launches an EC2 instance in the Sydney region (`ap-southeast-2`).
- Applies a security group to allow SSH access.
- Automatically sets the hostname inside the EC2 instance to match the `Name` tag given in Terraform.
- Outputs the instance's public IP and hostname.

---

## 🛠️ Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/downloads)
- An AWS account
- AWS credentials configured (`~/.aws/credentials` or via environment variables)
- A valid EC2 key pair in `ap-southeast-2` region (replace `your-key-name` in code)

---

## 📁 Project Structure

