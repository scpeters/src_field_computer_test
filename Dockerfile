FROM ros:indigo-ros-base

# add ihmc messages
RUN apt-get update \
 && apt-get install -y \
    ros-indigo-ihmc-msgs \
    ros-indigo-tf \
    ros-indigo-tf2 \
 && rm -rf /var/lib/apt/lists/*

# clone srcsim
ENV WS /home/docker/ws
RUN mkdir -p ${WS}/src
WORKDIR ${WS}/src
RUN hg clone https://bitbucket.org/osrf/srcsim

EXPOSE 8000

# start a roscore
CMD ["python", "-m", "SimpleHTTPServer", "8000"]
