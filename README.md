# Private Ethereum Blockchain on AWS EKS

This repository contains the infrastructure code and configurations necessary to deploy a private Ethereum blockchain using AWS Elastic Kubernetes Service (EKS), managed by Terraform, and monitored with Prometheus and Grafana.

## Table of Contents

- [Introduction](#introduction)
- [Prerequisites](#prerequisites)
- [Infrastructure Setup](#infrastructure-setup)
  - [Terraform Configuration](#terraform-configuration)
  - [Kubernetes Resources](#kubernetes-resources)
- [Architecture Overview](#architecture-overview)
  - [Network and Security Configuration](#Network-and-Security-Configuration)
- [Ethereum Blockchain Setup](#ethereum-blockchain-setup)
  - [Configuring Ethereum Nodes](#Configuring-Ethereum-Nodes)
  - [Genesis Block Configuration](#Genesis-Block-Configuration)
- [Monitoring Setup](#monitoring-setup)
  - [Prometheus](#Prometheus)
  - [Grafana](#Grafana)
- [Security and Access Control](#security-and-access-control)
- [Best Practices](#best-practices)
- [Troubleshooting Guide](#troubleshooting-guide)
- [References](#references)

## Introduction

This documentation provides detailed instructions on setting up a private Ethereum blockchain network on AWS, using EKS for orchestration. It covers the full scope from infrastructure setup with Terraform, operational monitoring with Prometheus and Grafana, to security configurations.

## Prerequisites

- An active AWS account with administrative access.
- AWS CLI installed and configured.
- Terraform v0.12+ installed.
- kubectl installed for Kubernetes interaction.
- Familiarity with Ethereum concepts, AWS services, and Kubernetes operations.

## Infrastructure Setup

### Terraform Configuration

1. **AWS Provider Setup**: Initialize your provider with AWS credentials.
2. **EKS Cluster**: Define and provision the EKS cluster and worker nodes using Terraform.
3. **Security Groups**: Set up security groups for secure access and communication.

### Kubernetes Resources

- Deploy Ethereum nodes as Kubernetes pods.
- Use Kubernetes services and ConfigMaps for network configurations and genesis block setup.

## Architecture Overview

This section provides a detailed overview of the architecture for the private Ethereum blockchain setup on AWS using Elastic Kubernetes Service (EKS). The architecture is designed to be secure, scalable, and resilient, utilizing AWS's managed services to optimize operational efficiency.

### Key Components

1. **AWS Elastic Kubernetes Service (EKS)**
   - **Control Plane**: Managed by AWS, it handles scheduling, orchestration, and the Kubernetes API. This component is automatically scaled and managed by AWS to ensure high availability and security.
   - **Worker Nodes**: EC2 instances that serve as worker nodes for the Kubernetes cluster. These nodes run the Ethereum blockchain nodes in Docker containers managed as Kubernetes pods.

2. **EC2 Bastion Host**
   - Serves as a secure entry point for administrators to access the Kubernetes nodes and the Ethereum blockchain nodes via SSH. It is placed in a public subnet with strict security group rules to allow only necessary SSH traffic.

3. **Virtual Private Cloud (VPC)**
   - **Subnets**:
     - **Public Subnets**: House the bastion host and provide access to the internet via an Internet Gateway. These subnets also host the Load Balancers that expose certain Kubernetes services.
     - **Private Subnets**: Contain the EKS worker nodes and other critical backend services like databases or internal applications, ensuring these components are not directly exposed to the internet.
   - **Route Tables**: Control the routing of traffic between subnets, the internet, and other AWS services.
   - **Network Access Control Lists (ACLs)** and **Security Groups**: Govern inbound and outbound traffic at the subnet and instance level to enhance security.

4. **Ethereum Setup**
   - **Nodes Deployment**: Ethereum nodes are deployed as stateful sets in Kubernetes to maintain their identity across restarts and rescheduling.
   - **Persistent Storage**: EKS utilizes Elastic Block Store (EBS) to provide persistent storage for each Ethereum node, ensuring data durability across pod restarts.

5. **Monitoring with Prometheus and Grafana**
   - **Prometheus**: Configured to automatically discover pods and scrape metrics from the Ethereum nodes and Kubernetes infrastructure. It stores these metrics for historical analysis and real-time monitoring.
   - **Grafana**: Connects to Prometheus as the data source to provide dashboards for visualizing and analyzing the performance and health of both the Ethereum network and the Kubernetes environment.

### Security Features

- **IAM Roles and Policies**: Grant minimal necessary permissions to services and operators to enhance security.
- **Encryption**: Utilizes AWS KMS for key management and encryption of EBS volumes and data at rest within the Ethereum nodes.
- **Network Security**: The use of private subnets for sensitive components and strict security groups around all resources minimizes exposure to external threats.

### Resilience and Scalability

- **Auto-scaling Groups**: EKS worker nodes are grouped into auto-scaling groups to allow the system to automatically adjust capacity and distribution across multiple availability zones to match load and optimize resilience and cost.
- **Multi-AZ Deployment**: Critical components, including data storage and load balancers, are deployed across multiple Availability Zones to ensure high availability.

For more detailed information on configuring each component, refer to the specific sections later in this documentation.

## Ethereum Blockchain Setup

- **Genesis Block Configuration**: Use a ConfigMap to specify the genesis block that initializes blockchain parameters.
- **Node Deployment**: Ethereum clients run as stateful sets within the Kubernetes cluster.

## Monitoring Setup

### Prometheus

- Configured to scrape metrics from Ethereum nodes and Kubernetes system metrics.

### Grafana

- Dashboards are set up to visualize metrics collected by Prometheus, providing insights into node and network performance.

## Security and Access Control

- **IAM Roles**: Define minimal access policies for services.
- **Security Groups**: Restrict access to resources strictly to necessary ports and IP ranges.
- **Network Policies**: Kubernetes network policies to control pod-to-pod communications.

## Best Practices

- Regularly update and patch images and dependencies.
- Monitor and audit access and activities using AWS CloudTrail and Kubernetes audit logs.

## Troubleshooting Guide

- Common issues and solutions related to deployment errors, connectivity issues, and performance bottlenecks.

## References

- [AWS Documentation](https://aws.amazon.com/documentation/)
- [Terraform Registry for AWS EKS Module](https://registry.terraform.io/modules/terraform-aws-modules/eks/aws)
- [Kubernetes Documentation](https://kubernetes.io/docs/)
