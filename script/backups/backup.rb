require_relative "../../config/environment"

def log(msg) = puts("==> #{msg}")

def sh(cmd)
  puts("$ #{cmd}")
  system(cmd, exception: true)
end

creds = Rails.application.credentials

ssh_port = creds.kamal!.ssh_port!
server = creds.kamal!.server!
user = creds.kamal!.ssh_user!
local_backups_dir = creds.deploy!.local_backups_directory!
remote_backups_directory = creds.deploy!.remote_backups_directory!

timestamp = Time.now.utc.iso8601
volume = "notes_#{Rails.env}_storage"
backup_file = "#{volume}_#{timestamp}.tgz"
local_dest = File.join(local_backups_dir, backup_file)
ssh_target = "#{user}@#{server}"

remote_cmd = "docker run --rm " \
  "-v #{volume}:/data:ro " \
  "-v #{remote_backups_directory}:/bkup " \
  "alpine sh -c " \
  "'rm -f /bkup/#{backup_file} && tar czf /bkup/#{backup_file} -C /data .'"

log "Running remote backup on #{ssh_target}..."
sh "ssh -p #{ssh_port} #{ssh_target} \"#{remote_cmd}\""

log "Downloading backup with rsync..."
sh "mkdir -p #{local_backups_dir}"
sh "rsync -avhPz " \
  "-e 'ssh -p #{ssh_port}' " \
  "#{ssh_target}:#{remote_backups_directory}/#{backup_file} " \
  "#{local_dest}"

log "Done!"
