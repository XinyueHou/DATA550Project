# Use an official R base image
FROM r-base:latest

# Install Linux dependencies
RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev

# Install R packages
RUN R -e "install.packages(c('dplyr', 'tidyverse', 'readr', 'ggplot2', 'knitr', 'kableExtra'), dependencies=TRUE)"

# Copy project files into the Docker image
COPY . /usr/local/src/project
WORKDIR /usr/local/src/project

# Set the command to run your analysis when the container starts
CMD ["Rscript", "DATA550_PROJECT2.R"]