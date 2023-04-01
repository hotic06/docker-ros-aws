#!/bin/bash
docker run -d \
-e http_proxy=${http_proxy} \
-e https_proxy=${https_proxy} \
-e HTTP_PROXY=${HTTP_PROXY} \
-e HTTPS_PROXY=${HTTPS_PROXY} \
-e RESOLUTION=1280x720 \
--name ros-melodic-vnc-aws \
-p 5900:5900 \
-p 6080:80 \
--shm-size=512m \
--privileged \
$* \
ros-melodic-vnc-aws:latest 
