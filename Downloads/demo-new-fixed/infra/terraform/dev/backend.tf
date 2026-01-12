# Optional: Remote state (recommended for teams)
# NOTE: Backend config cannot use variables. Fill exact values before enabling.
#
# terraform {
#   backend "s3" {
#     bucket         = "YOUR_TF_STATE_BUCKET"
#     key            = "vursa/dev/terraform.tfstate"
#     region         = "ap-south-1"
#     dynamodb_table = "YOUR_TF_LOCK_TABLE"
#     encrypt        = true
#   }
# }
