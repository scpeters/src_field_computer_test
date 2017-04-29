FROM ros:indigo-ros-base

# add ihmc messages
RUN apt-get update \
 && apt-get install -y \
    ros-indigo-ihmc-msgs \
 && rm -rf /var/lib/apt/lists/*

# clone srcsim
RUN hg clone https://bitbucket.org/osrf/srcsim

# start a roscore
CMD ["python", "-m", "SimpleHTTPServer", "8000"]
