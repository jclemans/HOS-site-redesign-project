listen 10000
worker_processes 1 # Do NOT change this, it will fuck up the scheduler.
pid 'tmp/rainbows.pid'
Rainbows! do
  use :ThreadSpawn
  worker_connections 200
end
