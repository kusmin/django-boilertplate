FROM python:3.11

ARG REQUIREMENTS_FILE

WORKDIR /app
EXPOSE 80
ENV PYTHONUNBUFFERED 1

RUN set -x && \
	apt-get update && \
	apt -f install	&& \
	apt-get -qy install netcat-openbsd libpq-dev && \
	rm -rf /var/lib/apt/lists/* && \
	wget -O /wait-for https://raw.githubusercontent.com/eficode/wait-for/master/wait-for && \
	chmod +x /wait-for

CMD ["sh", "/entrypoint-web.sh"]
COPY ./docker/ /

COPY ./requirements/ ./requirements
RUN python -m pip install --upgrade pip==20.2.4 && python -m pip install ipython==8.17.2
RUN pip install -r requirements/dev.txt

COPY . ./

# Saved changes
