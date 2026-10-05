#!/usr/bin/env bash
set -euo pipefail

project_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
stamp="$(date +%Y%m%d-%H%M%S)"
backup_dir="${project_dir}/backups/${stamp}"

mkdir -p "${backup_dir}"
cd "${project_dir}"
docker compose run --rm wpcli wp db export "/var/www/html/backups/${stamp}/database.sql"
tar -czf "${backup_dir}/wp-content.tar.gz" wp-content
printf 'Backup guardado en %s\n' "${backup_dir}"
