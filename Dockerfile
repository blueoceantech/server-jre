FROM buildpack-deps:jessie-scm

RUN apt-get update && apt-get install -y --no-install-recommends \
		bzip2 \
		unzip \
		xz-utils \
	&& rm -rf /var/lib/apt/lists/*

RUN echo 'deb http://deb.debian.org/debian jessie-backports main' > /etc/apt/sources.list.d/jessie-backports.list

ENV LANG C.UTF-8


COPY ["./jdk1.8", "/usr/lib/jvm/" ]

# add a simple script that can auto-detect the appropriate JAVA_HOME value
# based on whether the JDK or only the JRE is installed
#RUN chmod +x /usr/lib/jvm/bin/java

ENV JAVA_HOME /usr/lib/jvm

ENV JAVA_VERSION 8u131
#ENV JAVA_DEBIAN_VERSION 8u121-b13-1~bpo8+1

#ENV CA_CERTIFICATES_JAVA_VERSION 20161107~bpo8+1

#RUN set -x && apt-get update && rm -rf /var/lib/apt/lists/*

RUN update-alternatives --install "/usr/bin/java" "java" "/usr/lib/jvm/bin/java" 1
RUN update-alternatives --install "/usr/bin/javac" "javac" "/usr/lib/jvm/bin/javac" 1
RUN update-alternatives --config java
