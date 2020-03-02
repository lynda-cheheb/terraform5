# create address resource========================================================================
resource "azurerm_resource_group" "rg" {
  name     = "${var.name}"
  location = "${var.location}"

  tags {
    owner = "${var.owner}"
  }
}

# create a virtual network =====================================================================
resource "azurerm_virtual_network" "azVirNetwork" {
  name                = "myVirtualNetwork"
  location            = "${azurerm_resource_group.rg.location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  address_space       = ["10.0.0.0/16"]

}

# create subnet================================================================================
resource "azurerm_subnet" "MyFirstSubnet_1" {
  name                 = "subnet_1"
  resource_group_name  = "${azurerm_resource_group.rg.name}"
  virtual_network_name = "${azurerm_virtual_network.azVirNetwork.name}"
  address_prefix       = "10.0.1.0/24"
}

resource "azurerm_subnet" "MyFirstSubnet_2" {
  name                 = "subnet_2"
  resource_group_name  = "${azurerm_resource_group.rg.name}"
  virtual_network_name = "${azurerm_virtual_network.azVirNetwork.name}"
  address_prefix       = "10.0.2.0/24"
}

resource "azurerm_subnet" "MyFirstSubnet_3" {
  name                 = "subnet_3"
  resource_group_name  = "${azurerm_resource_group.rg.name}"
  virtual_network_name = "${azurerm_virtual_network.azVirNetwork.name}"
  address_prefix       = "10.0.3.0/24"
}

# create address ip===============================================================================
resource "azurerm_public_ip" "myFirstPubIp_1" {
  name = "my_ip"
  location = "${var.location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  allocation_method = "Dynamic"
}

# create a network security group========================================================
resource "azurerm_network_security_group" "myFirstNsg_1" {
  name= "nsg_1"
  location= "${var.location}"
  resource_group_name= "${azurerm_resource_group.rg.name}"

  security_rule{
    name= "SSH"
    priority= "1001"
    direction= "Inbound"
    access= "Allow"
    protocol= "Tcp"
    source_port_range= "*"
    destination_port_range= "22"
    source_address_prefix= "*"
    destination_address_prefix= "*"
  }

  security_rule{
   name = "HTTP"
   priority = "1002"
   direction = "Inbound"
   access = "Allow"
   protocol = "Tcp"
   source_port_range = "*"
   destination_port_range = "80"
   source_address_prefix = "*"
   destination_address_prefix = "*"
  }

  security_rule{
    name= "jenkins-SSH"
    priority= "1003"
    direction= "Inbound"
    access= "Allow"
    protocol= "Tcp"
    source_port_range= "*"
    destination_port_range= "8080"
    source_address_prefix= "*"
    destination_address_prefix= "*"
  }
}

resource "azurerm_network_security_group" "myFirstNsg_2" {
  name= "nsg_2"
  location= "${var.location}"
  resource_group_name= "${azurerm_resource_group.rg.name}"

  security_rule{
    name= "SSH"
    priority= "1001"
    direction= "Inbound"
    access= "Allow"
    protocol= "Tcp"
    source_port_range= "*"
    destination_port_range= "22"
    source_address_prefix= "*"
    destination_address_prefix= "*"
  }

  security_rule{
   name = "HTTP"
   priority = "1002"
   direction = "Inbound"
   access = "Allow"
   protocol = "Tcp"
   source_port_range = "*"
   destination_port_range = "80"
   source_address_prefix = "*"
   destination_address_prefix = "*"
  }

  security_rule{
    name= "jenkins-SSH"
    priority= "1003"
    direction= "Inbound"
    access= "Allow"
    protocol= "Tcp"
    source_port_range= "*"
    destination_port_range= "8080"
    source_address_prefix= "*"
    destination_address_prefix= "*"
  }
}

resource "azurerm_network_security_group" "myFirstNsg_3" {
  name= "nsg_3"
  location= "${var.location}"
  resource_group_name= "${azurerm_resource_group.rg.name}"

  security_rule{
    name= "SSH"
    priority= "1001"
    direction= "Inbound"
    access= "Allow"
    protocol= "Tcp"
    source_port_range= "*"
    destination_port_range= "22"
    source_address_prefix= "*"
    destination_address_prefix= "*"
  }

  security_rule{
   name = "HTTP"
   priority = "1002"
   direction = "Inbound"
   access = "Allow"
   protocol = "Tcp"
   source_port_range = "*"
   destination_port_range = "80"
   source_address_prefix = "*"
   destination_address_prefix = "*"
  }

  security_rule{
    name= "jenkins-SSH"
    priority= "1003"
    direction= "Inbound"
    access= "Allow"
    protocol= "Tcp"
    source_port_range= "*"
    destination_port_range= "8080"
    source_address_prefix= "*"
    destination_address_prefix= "*"
  }
}
# create a network interface========================================================================
resource "azurerm_network_interface" "myFirstNIC_1" {
  name = "myNIC_1"
  location = "${var.location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  network_security_group_id = "${azurerm_network_security_group.myFirstNsg_1.id}"
  ip_configuration{
    name = "ipConfig_1"
    subnet_id = "${azurerm_subnet.MyFirstSubnet_1.id}"
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface" "myFirstNIC_2" {
  name = "myNIC_2"
  location = "${var.location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  network_security_group_id = "${azurerm_network_security_group.myFirstNsg_2.id}"
  ip_configuration{
    name = "ipConfig_2"
    subnet_id = "${azurerm_subnet.MyFirstSubnet_2.id}"
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface" "myFirstNIC_3" {
  name = "myNIC_3"
  location = "${var.location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  network_security_group_id = "${azurerm_network_security_group.myFirstNsg_3.id}"
  ip_configuration{
    name = "ipConfig_3"
    subnet_id = "${azurerm_subnet.MyFirstSubnet_3.id}"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = "${azurerm_public_ip.myFirstPubIp_1.id}"
  }
}
# create a virtual machine =====================================================================
resource "azurerm_virtual_machine" "myFirstVM_1"{
  name = "VM1"
  location = "${var.location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  network_interface_ids = ["${azurerm_network_interface.myFirstNIC_1.id}"]
  vm_size = "${var.vmSize}"

  storage_os_disk{
    name ="myDisk_1"
    caching = "ReadWrite"
    create_option = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  storage_image_reference{
    publisher = "OpenLogic"
    offer = "CentOS"
    sku = "7.6"
    version = "latest"
  }
  os_profile{
    computer_name = "vmLynda1"
    admin_username = "lynda"
  }
  os_profile_linux_config {
    disable_password_authentication = true

    ssh_keys{
       path =  "/home/lynda/.ssh/authorized_keys"
       key_data = "${var.key_data}"
    }
  }
}

resource "azurerm_virtual_machine" "myFirstVM_2"{
  name = "VM2"
  location = "${var.location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  network_interface_ids = ["${azurerm_network_interface.myFirstNIC_2.id}"]
  vm_size = "${var.vmSize}"

  storage_os_disk{
    name ="myDisk_2"
    caching = "ReadWrite"
    create_option = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  storage_image_reference{
    publisher = "OpenLogic"
    offer = "CentOS"
    sku = "7.6"
    version = "latest"
  }
  os_profile{
    computer_name = "vmLynda2"
    admin_username = "lynda"
  }
  os_profile_linux_config {
    disable_password_authentication = true

    ssh_keys{
       path =  "/home/lynda/.ssh/authorized_keys"
       key_data = "${var.key_data}"
    }
  }
}

resource "azurerm_virtual_machine" "myFirstVM_3"{
  name = "VM3"
  location = "${var.location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  network_interface_ids = ["${azurerm_network_interface.myFirstNIC_3.id}"]
  vm_size = "${var.vmSize}"

  storage_os_disk{
    name ="myDisk_3"
    caching = "ReadWrite"
    create_option = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  storage_image_reference{
    publisher = "OpenLogic"
    offer = "CentOS"
    sku = "7.6"
    version = "latest"
  }
  os_profile{
    computer_name = "vmLynda3"
    admin_username = "lynda"
  }
  os_profile_linux_config {
    disable_password_authentication = true

    ssh_keys{
       path =  "/home/lynda/.ssh/authorized_keys"
       key_data = "${var.key_data}"
    }
  }
}
