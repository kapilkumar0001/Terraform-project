terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "2.88.1"
    }
  }
}

provider "azurerm" {
  # Configuration options
    features {}

} 
resource "azurerm_resource_group" "terraform_resource_group"{
    name = "terraform_resource_group"
    location = "EAST US"
}
/*
module "linuxservers" {
  source              = "Azure/compute/azurerm"
  resource_group_name = azurerm_resource_group.terraform_resource_group.name
  vm_os_simple        = "UbuntuServer"
  public_ip_dns       = ["linsimplevmips"] // change to a unique name per datacenter region
  vnet_subnet_id      = module.network.vnet_subnets[0]
  vm_size             = "Standard_B1ls"   
  depends_on = [azurerm_resource_group.terraform_resource_group]
}
*/
module "windowsservers" {
  source              = "Azure/compute/azurerm"
  resource_group_name = azurerm_resource_group.terraform_resource_group.name
  is_windows_image    = true
  vm_hostname         = "mywinvm" // line can be removed if only one VM module per resource group
  admin_password      = "ComplxP@ssw0rd!"
  vm_os_simple        = "WindowsServer"
  public_ip_dns       = ["winsimplevmips"] // change to a unique name per datacenter region
  vnet_subnet_id      = module.network.vnet_subnets[0]

  depends_on = [azurerm_resource_group.terraform_resource_group]
}

module "network" {
  source              = "Azure/network/azurerm"
  resource_group_name = azurerm_resource_group.terraform_resource_group.name
  subnet_prefixes     = ["10.0.111.0/24"]
  subnet_names        = ["subnet1"]
 
  depends_on = [azurerm_resource_group.terraform_resource_group]
}

output "linux_vm_public_name" {
  value = module.windowsservers.public_ip_dns_name
}
