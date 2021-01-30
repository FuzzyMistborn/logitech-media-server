# Docker Container for Logitech Media Server
This is a barebones docker file for running Logitech Media Server in Docker.  Currently based on the 8.0 releases.  Updated only as I can remember (mostly for personal use)

## Docker-Compose file
```
  lms:
    container_name: logitech_media_server
    image: fuzzymistborn/logitech_media_server:latest
    volumes:
      - ./lms/data:/var/lib/squeezeboxserver
      - ./lms/logs:/var/log/squeezeboxserver
      - ./lms/playlists:/mnt/playlists
    restart: always
    network_mode: host
```

