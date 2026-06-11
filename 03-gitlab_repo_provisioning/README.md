# GitLab Repository Provisioning with OpenTofu

This project demonstrates a production-grade Infrastructure as Code (IaC) setup for dynamically managing GitLab repositories using **OpenTofu**. 

It is built with scalability, security, and reusability in mind, utilizing advanced OpenTofu features such as custom modules, dynamic looping, and strict secret management.

## 🏗️ Architecture & Concepts

* **Data-Driven Scalability (`for_each`)**: Repositories are not hardcoded as individual resource blocks. Instead, they are defined as a data map in `terraform.tfvars`. A `for_each` loop dynamically provisions repositories based on this map, making it effortless to scale from 1 to 100 repositories.
* **Custom Modules**: The repository logic is encapsulated within a custom local module (`./modules/repository`). This abstracts away the complexity of repository configuration and makes the code highly reusable.
* **Secure Secret Management**: Sensitive credentials (like Personal Access Tokens) are **never** written to disk. The GitLab provider is configured to ingest the `GITLAB_TOKEN` directly from local environment variables.
* **Environment Structuring**: Variable schemas are defined in `variables.tf`, while the actual deployment data is passed securely via `terraform.tfvars` (which is excluded from version control).

## 📁 Project Structure

```text
03-repository_provisioning/
├── modules/
│   └── repository/
│       ├── main.tf         # The core gitlab_project resource logic
│       └── variables.tf    # Inputs required by the module
├── main.tf                 # The root entry point calling the custom module
├── variables.tf            # The root variable schema defining the map structure
├── versions.tf             # Provider requirements (gitlabhq/gitlab)
└── terraform.tfvars        # (Ignored in Git) The actual repository data definitions
```

## 🚀 How to Run

### 1. Set up Authentication
Generate a Personal Access Token (PAT) in GitLab with the `api` scope. Export it to your terminal session securely:

```zsh
export GITLAB_TOKEN="glpat-YOUR_TOKEN_HERE"
```

### 2. Initialize the Project
Download the required GitLab provider and initialize the local module:

```zsh
tofu init
```

### 3. Plan the Deployment
Preview the infrastructure changes based on the data provided in your `.tfvars` file:

```zsh
tofu plan
```

### 4. Apply the Infrastructure
Deploy the repositories to GitLab:

```zsh
tofu apply
```

*Note: This project is strictly managed by OpenTofu. Manual changes made in the GitLab UI will be detected as drift and reverted during the next `apply`.*