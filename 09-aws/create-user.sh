aws iam create-user --user-name alex
aws iam create-group --group-name devops
aws iam add-user-to-group --user-name alex --group-name devops
aws iam attach-group-policy --group-name devops --policy-arn arn:aws:iam::aws:policy/AmazonEC2FullAccess
aws iam attach-group-policy --group-name devops --policy-arn arn:aws:iam::aws:policy/AmazonVPCFullAccess
aws iam create-access-key --user-name alex > ~/.aws/alex_credentials
