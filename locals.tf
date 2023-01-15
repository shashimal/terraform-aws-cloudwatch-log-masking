locals {
  app_name = "employee-audit-log-notification"
  audit_logs_bucket_name = "dss-employee-audit-logs"

  pii_data_identifiers = [
    "arn:aws:dataprotection::aws:data-identifier/Name",
    "arn:aws:dataprotection::aws:data-identifier/Address",
    "arn:aws:dataprotection::aws:data-identifier/DateOfBirth",
    "arn:aws:dataprotection::aws:data-identifier/EmailAddress",
    "arn:aws:dataprotection::aws:data-identifier/VehicleIdentificationNumber",
    "arn:aws:dataprotection::aws:data-identifier/ZipCode-US"
  ]
}