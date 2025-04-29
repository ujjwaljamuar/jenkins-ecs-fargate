#!/bin/bash

cd terraform 

# Initialize Terraform
terraform init

# Plan the deployment
terraform plan

# Apply the changes
terraform apply -auto-approve
