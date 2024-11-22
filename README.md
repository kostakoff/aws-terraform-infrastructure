# aws-terraform-infrastructure

## Requirments

- deploy-sa user account
> should have default AWS Policies: AmazonEC2FullAccess, AmazonMSKFullAccess, AmazonRoute53FullAccess, AWSCertificateManagerReadOnly, IAMReadOnlyAccess,
> and custom AWS Policies: CustomEKSAdmin, CustomCertificateViewer
- eks-sa role
> should have default AWS Policy - AmazonEKSClusterPolicy
- eksNodeGroup-sa
> should have  default AWS Policies: AmazonEC2ContainerRegistryReadOnly, AmazonEKS_CNI_Policy, AmazonEKSWorkerNodePolicy

## cli examples
- terraform plan
```bash
terraform plan
```
- terrafrom apply
```bash
terrafrom apply --auto-approve
```
- terrafrom destroy
```bash
terrafrom destroy --auto-approve
```
