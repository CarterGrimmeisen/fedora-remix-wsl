FROM fedora-remix-wsl
ARG password

USER root
RUN dnf install git unzip fish vim httpie nodejs ripgrep bat docker btop sqlite -y

RUN adduser carter
RUN usermod -aG wheel carter
RUN usermod -aG docker carter
RUN echo $password | passwd carter --stdin

USER carter
WORKDIR /home/carter
SHELL ["/usr/bin/fish", "-c"]
ENV SHELL=/usr/bin/fish

RUN curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
RUN fisher install oh-my-fish/plugin-bang-bang
RUN fisher install IlanCosman/tide@v5
RUN echo -e '1\n2\n1\n2\n1\n2\n1\ny\n' | tide configure > /dev/null
RUN git config --global user.name "Carter Grimmeisen"
RUN alias --save cat=bat