# Terraform x CloudFormation

Export the Terraform Outputs from Terraform-State-File and use them in your CloudFormation based infrastructure using CloudFormation-Custom-Resources.

### Create Terraform based infrastructure _(Optional)_
Go into the folder named _**http-alb**_ which has HCL scripts to create http-based ALB that has a couple of instances behind the target-group.
Use below commands in sequence to deploy through Terraform:
`terraform init`
`terraform plan`
`terraform apply`

### Upload the Terraform State FIle to S3
   After successfull execution of step 1, you will see a new file named `terraform.tfstate` in _**http-alb**_ folder. Upload this file to an S3 bucket in your AWS account _(where you are going to deploy CloudFormation based infra)_.
   _**if you didn't perform the step 1 then you can use a sample Terraform state file present at the root of this project.**_

### Export Terraform Outputs in CloudFormation based infra
Open the CloudFormation script named `cross-site-cloudformation.yml`, navigate to the resource named `tfStateOutputsExport`. There is a list based property named `DesiredOutputs`. Enter names of the Terraform outputs that you want to export in your CloudFormation based infrastructure. If this list is empty then all outputs from your Terraform state file will be exported.

Also, in the **Outputs** section, use the Custom-Resource response data to export the outputs.

Now, Create a stack in your AWS account _(where you are going to deploy CloudFormation based infra)_ using this script. This script has below resources:
- Lambda Backed Custom Resource to export the Terraform outputs
- Lambda function that fetches the outputs from Terraform State File on S3
- IAM Role for Lambda function with proper permissions
- Outputs that you want to export into your CloudFormation infra

---
After successfull execution of the CloudFormation script, you will be able to see the Outputs into your AWS Stack's Outputs section and these can be used across your CloudFormation based infra.