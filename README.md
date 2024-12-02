# tf-aws-infra

## Terraform instructions
- Initialise terraform using "terraform init"
- Preview infra changes using "terraform plan"
- Apply changes to infra using "terraform apply"
- Destroy infra using "terraform destroy"

## Importing SSL
- Generated CSR and private key
- Activated SSL using CNAME and CSR
- Used the received files in the following way to import the certificate
```bash
aws acm import-certificate --certificate fileb://C:\Users\rupes\cloud_fall24\certificates\demo\demo_rupeshrokade_me.crt --certificate-chain fileb://C:\Users\rupes\cloud_fall24\certificates\demo\demo_rupeshrokade_me.ca-bundle --private-key fileb://C:\Users\rupes\cloud_fall24\certificates\demo\PrivateKey.pem.txt