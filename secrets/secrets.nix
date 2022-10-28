let
  # computer host keys
  manara = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF7lAXbJmLcEWJLCsc69eWHdFyK2OgerRBgnNzAlx8N8 root@manara";

  # user keys
  jblManara = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBW7Hi6m5Tu1yZudaGOq+LcUq/o85sy0MZXI+KZhaNaV jbl@manara";
  allKeys = [ manara jblManara ];
in
{
  "secret.age".publicKeys = allKeys;
}
