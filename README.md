# Terraform ✖ CloudFormation

Export the Terraform Outputs from Terraform-State-File and use them in your CloudFormation based infrastructure using CloudFormation-Custom-Resources.

##### 1. Create Terraform based infrastructure _(Optional)_
Go into the folder named [_**http-alb**_](https://github.com/afraz-khan/cloud-task/tree/main/http-alb) which has HCL scripts to create http-based ALB that has a couple of ec2 instances behind the target-group.
Use below commands in sequence to deploy through Terraform:  
`terraform init`
`terraform plan`
`terraform apply`
> Its optional step, you can use [_**this**_](https://github.com/afraz-khan/cloud-task/blob/main/terraform.tfstate) sample terraform state file 

##### 2. Upload the Terraform State FIle to S3
   If you chose to execute step 1 then after successful execution, you will see a new file named `terraform.tfstate` in [_**http-alb**_](https://github.com/afraz-khan/cloud-task/tree/main/http-alb) folder otherwise you can use sample terraform state file [_**here**_](https://github.com/afraz-khan/cloud-task/blob/main/terraform.tfstate). 
   Upload this file to an S3 bucket in your AWS account _(where you are going to deploy CloudFormation based infra)_.

##### 3. Export Terraform Outputs in CloudFormation based infra
Open the CloudFormation script named `cross-site-cloudformation.yml` [_**here**_](https://github.com/afraz-khan/cloud-task/blob/main/cross-site-cloudformation.yml). 

Open this file and navigate to the resource named `tfStateOutputsExport` in the **Resources** section. There is a list based property named `DesiredOutputs`. Enter names of the Terraform outputs that you want to export in your CloudFormation based infrastructure. If this list is empty then all outputs from your Terraform state file will be exported.
Also, in the **Outputs** section, use the Custom-Resource response data to export the outputs. Currently, two outputs are exported in the script, an ALB URL and instance id of one of the instances deployed through Terraform.

After making your desired changes, save the script.

Now, Create a stack in your AWS account _(where you are going to deploy CloudFormation based infra)_ using this script. This script has below resources:
- Lambda Backed Custom Resource to export the Terraform outputs
- Lambda function that fetches the outputs from Terraform State File on S3
- IAM Role for Lambda function with proper permissions
- Outputs that you want to export into your CloudFormation infra

---
After successfull execution of the CloudFormation script🚀, you will be able to see the Outputs into your AWS Stack's **Outputs** section and these can be used across your CloudFormation based infra using the `!GetAttr` psuedo function. 🎊🎊
Let me know if any changes/requirements needed or any confusions you experience 🙂 
