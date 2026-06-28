require_relative "../config/environment"

def log(msg) = puts("==> #{msg}")

def sh(cmd)
  puts("$ #{cmd}")
  system(cmd, exception: true)
end

local_backup = ARGV.first or raise "missing argument FILE"
if !File.exist?(local_backup) || File.directory?(local_backup)
  raise "invalid FILE"
end

creds = Rails.application.credentials

ssh_port = creds.kamal!.ssh_port!
server = creds.kamal!.server!
user = creds.kamal!.ssh_user!
remote_tmp = "/tmp/restore.tgz"
volume = "notes_#{Rails.env}_storage"

log "Uploading backup to server..."
sh "rsync -avhPz " \
  "-e 'ssh -p #{ssh_port}' " \
  "#{local_backup} #{user}@#{server}:#{remote_tmp}"

log "Restoring backup into Docker volume..."

cmd = "docker run --rm " \
    "-v #{volume}:/data " \
    "-v /tmp:/backups " \
    "alpine sh -c 'rm -rf /data/* && tar xzf /backups/restore.tgz -C /data'"

sh "ssh -p #{ssh_port} #{user}@#{server} \"#{cmd}\""
sh "ssh -p #{ssh_port} #{user}@#{server} 'rm -v #{remote_tmp}'"

log "Restore complete from #{local_backup}"
