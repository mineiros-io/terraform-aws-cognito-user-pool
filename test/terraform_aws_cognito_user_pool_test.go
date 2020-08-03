package test

import (
	"fmt"
	"strings"
	"testing"

	"github.com/gruntwork-io/terratest/modules/aws"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestCognitoUserPool(t *testing.T) {
	t.Parallel()

	// Regions that support AWS Cognito as of 06/2020
	availableRegions := []string{
		"ca-central-1",
		"us-east-1",
		"us-east-2",
		"us-west-2",
		"ap-south-1",
		"ap-northeast-1",
		"ap-northeast-2",
		"ap-southeast-1",
		"ap-southeast-2",
		"eu-central-1",
		"eu-west-1",
		"eu-west-2",
	}

	randomAwsRegion := aws.GetRandomRegion(t, availableRegions, nil)
	userPoolName := strings.ToLower(fmt.Sprintf("cognito-user-pool-%s", random.UniqueId()))

	terraformOptions := &terraform.Options{
		// The path to where your Terraform code is located
		TerraformDir: "./user-pool",
		Vars: map[string]interface{}{
			"aws_region": randomAwsRegion,
			"name":       userPoolName,
		},
		Upgrade: true,
	}

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)

	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApplyAndIdempotent(t, terraformOptions)
}
