## Demo IaaC Deployment on Bitbucket

This pipeline demonstrates the IaaC Deployment for a VPC (Virtual Private Cloud). There are 2 steps in this pipeline **Terraform Infrastructure Deployment**  and **"(DESTROY)Terraform Infrastructure Destroy"**

---

## Terraform Infrastructure Deployment step
In this step the lambda function codes are compiled and subsequent uploaded to a designated s3 bucket as lambda_function.zip.

Steps to trigger the step.

1. Click **Pipelines** on the left side.

2. Click the **Run Pipelines** button on the top right.

3. Select the **master** branch.

4. Select the env PROD/DEV.

5. Select the **custom:Terraform Infrastructure Deployment** pipeline.

6. Click **Run** to trigger the pipeline.

---

## (DESTROY) Terraform Infrastructure Destroy step
In this step, we peform terraform destroy which tears down the lambda function.

Steps to trigger the step.

1. Click **Pipelines** on the left side.

2. Click the **Run Pipelines** button on the top right.

3. Select the **master** branch.

4. Select the env PROD/DEV.

5. Select the **(DESTROY)Terraform Infrastructure Destroy** pipeline.

6. Click **Run** to trigger the pipeline.

---

## Directory structure
The directory structure for this project as below:

```bash
.
├── README.md
├── bitbucket-pipelines.yml
└── terraform
    ├── env
    │   ├── dev.tfvar
    │   └── prod.tfvar
    ├── provider.tf
    ├── variables.tf
    └── vpc.tf
```