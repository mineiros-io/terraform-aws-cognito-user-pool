<img src="https://i.imgur.com/t8IkKoZl.png" width="200"/>

[![Maintained by Mineiros.io](https://img.shields.io/badge/maintained%20by-mineiros.io-00607c.svg)](https://www.mineiros.io/ref=terraform-module-template)
[![Terraform Version](https://img.shields.io/badge/terraform-~%3E%200.12.20-brightgreen.svg)](https://github.com/hashicorp/terraform/releases)
[![License](https://img.shields.io/badge/License-Apache%202.0-brightgreen.svg)](https://opensource.org/licenses/Apache-2.0)

# What this example shows

This example shows how to make a module depend on external hidden dependencies
using the `module_depends_on` list of dependencies.

How to implement this is discussed in more detail in our article
[The Ultimate Guide on How to Write Terraform Modules — Part 1 — Building a Foundation](https://medium.com/mineiros/the-ultimate-guide-on-how-to-write-terraform-modules-part-1-81f86d31f024)
and implementation details can be seen in the code of the
module this example uses: [terraform-null-resource](../../modules/terraform-null-resource).

## Basic usage
The code in [main.tf](main.tf) defines two resources and two modules where
one module depends on one of the resources.
```
```

## Running the example

### Cloning the repository
```
git clone https://github.com/mineiros-io/terraform-module-template.git
cd terraform-module-template/terraform/examples/module_depends_on
```

### Initializing Terraform
Run `terraform init` to initialize the example. The output should look like:
```
```

### Applying the example
Run `terraform apply -auto-approve` to create the resources.
```
```

### Destroying the example
Run `terraform destroy -refresh=false -auto-approve` to destroy all resources again.
```
```
