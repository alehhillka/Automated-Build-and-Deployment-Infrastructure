Description:

This project focuses on automating the setup of an AWS infrastructure and creating a deployment pipeline for a Node.js application. The project is divided into several parts, each addressing a specific aspect of the development and deployment process:

Part 1: Infrastructure Setup with Terraform

Set up a Virtual Private Cloud (VPC) with a public subnet.
Configure necessary Security Groups.
Leveraged Terraform to automate the infrastructure provisioning.

Part 2: Jenkins Setup

Deployed a Jenkins instance on an Amazon EC2 instance within the public subnet.
Installed and configured essential Jenkins plugins manually.

Part 3: Anti-Malware Deployment with Ansible

Created an Ansible role to install the anti-malware agent ClamAV on all EC2 instances in the AWS account.
Developed a Jenkins pipeline for executing the Ansible role.

Part 4: Docker Image Build and ECR Integration

Implemented a Jenkins pipeline for building a Node.js Docker image from a GitHub repository.
Utilized parameterization for selecting the Git branch or tag.
Created an Elastic Container Registry (ECR) and included Terraform code from Part 1.

Part 5: Static Files Deployment with CloudFront and S3

Set up a Cloudfront distribution and two S3 buckets (dev & prod) using Terraform.
Configured S3 buckets as origins, with URL path routing (default to prod, /dev/** for dev).
Integrated Terraform code from Part 1.
Developed a parameterized Jenkins pipeline to upload files from the Git repository to the chosen S3 bucket (dev or prod) and perform cache invalidation.

Part 6: Scalable Containerized Infrastructure with Load Balancing

The environment consists of three EC2 instances in private networks created through an Auto Scaling Group (ASG).
Each EC2 instance has Docker installed.
Docker containers run a Node.js application (built in Part 3) and an Nginx proxy.
Nginx is configured to route traffic to the Node.js container and exposes port 80.
An Application Load Balancer (ALB) balances traffic between the live EC2 instances, with port 80 externally open.

Part 7: Monitoring with Prometheus and Grafana

Implemented monitoring for the environment using Prometheus and Grafana.
Configured Prometheus to collect and store metrics from various sources within the infrastructure.
Grafana was set up to provide a user-friendly dashboard for visualizing and analyzing collected metrics.
This monitoring solution enhances visibility into the performance and health of the AWS infrastructure and the deployed applications.
