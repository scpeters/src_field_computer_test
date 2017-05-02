FROM ros:indigo-ros-base

# add ihmc messages
RUN apt-get update \
 && apt-get install -y \
    ros-indigo-rosbag \
    ros-indigo-ihmc-msgs \
    ros-indigo-tf \
    ros-indigo-tf2 \
 && rm -rf /var/lib/apt/lists/*

# clone srcsim
ENV WS /home/docker/ws
RUN mkdir -p ${WS}/src
WORKDIR ${WS}/src
RUN hg clone https://bitbucket.org/osrf/srcsim

# include bag file with footsteps preprogrammed
ADD footsteps_2017-05-02-14-40-59.bag ${WS}/
RUN echo "while rosbag play ${WS}/src/2017-05-02-14-40-59.bag && python scripts/rossleep.py 8; do date; done" \
  > do_footsteps.bash

EXPOSE 8000

# start a roscore
CMD ["python", "-m", "SimpleHTTPServer", "8000"]
