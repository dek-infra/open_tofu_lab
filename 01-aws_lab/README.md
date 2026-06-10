# Lab 1: OpenTofu Fundamentals with LocalStack

Welcome to Lab 1! This lab demonstrates how to use **OpenTofu** (an open-source alternative to Terraform) to provision and manage AWS resources locally using **LocalStack**.

By using LocalStack, we can safely simulate an AWS environment on our local machine without incurring any cloud costs.

## 📁 Project Structure

This project follows OpenTofu/Terraform best practices by separating configurations into logical files:

- **`docker-compose.dev.yaml`**: Spins up the LocalStack container to simulate AWS services.
- **`providers.tf`**: Configures the AWS provider to route requests to our LocalStack container instead of real AWS endpoints.
- **`variables.tf`**: Defines inputs, such as the `servers` map, which specifies the instance types for our mock EC2 instances.
- **`main.tf`**: Contains the core infrastructure resource definitions (e.g., `aws_instance`) utilizing dynamic meta-arguments like `for_each`.
- **`outputs.tf`**: Outputs useful information, such as the IDs of the created instances, after a successful apply.

## 🚀 How to Run the Lab

### 1. Start LocalStack

First, start the LocalStack Docker container in the background:

```bash
docker compose -f docker-compose.dev.yaml up -d
```

_Note: Ensure your Docker daemon is running (especially if using WSL)._

### 2. Initialize OpenTofu

Initialize the working directory. This downloads the necessary provider plugins (like the AWS provider):

```bash
tofu init
```

### 3. Plan the Infrastructure

Preview the changes OpenTofu is about to make. You should see 3 EC2 instances (web, db, analytics) scheduled for creation:

```bash
tofu plan
```

### 4. Apply the Infrastructure

Provision the simulated resources in LocalStack:

```bash
tofu apply
```

Type `yes` when prompted to confirm the deployment.

### 5. Clean Up

When you are done experimenting, tear down the virtual infrastructure and stop the LocalStack container:

```bash
tofu destroy -auto-approve
docker compose -f docker-compose.dev.yaml down
```
