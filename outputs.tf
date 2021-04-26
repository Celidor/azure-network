output "vm_linux_password" {
  value = random_string.value.result
}

output "vm_windows_password" {
  value = random_string.windows.result
}
