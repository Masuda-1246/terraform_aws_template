output "frontend_sg_id" {
  value = module.frontend_sg.security_group_id
}

output "backend_sg_id" {
  value = module.backend_sg.security_group_id
}

output "rds_sg_id" {
  value = module.rds_sg.security_group_id
}