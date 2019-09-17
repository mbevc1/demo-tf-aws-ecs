variable "pet_prefixes" {
  description = "List of animal prefixes"
  default     = ["fido", "felix", "duke", "sally"]
}

resource "random_shuffle" "pet" {
  input = [
    for pet in var.pet_prefixes:
    upper(pet)
  ]
}

output "shuffled_output" {
  value = random_shuffle.pet.result
}

output "shuffled_output_splat" {
  value = "${random_shuffle.pet.*.result}"
}
