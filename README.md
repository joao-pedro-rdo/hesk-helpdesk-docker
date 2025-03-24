# 📬 HESK Helpdesk (Docker)

[![Docker Pulls](https://img.shields.io/docker/pulls/joaoprdo/hesk-helpdesk)](https://hub.docker.com/r/joaoprdo/hesk-helpdesk)  
[![GitHub stars](https://img.shields.io/github/stars/joao-pedro-rdo/hesk-helpdesk-docker?style=social)](https://github.com/joao-pedro-rdo/hesk-helpdesk-docker)

Uma imagem Docker oficial para o HESK Helpdesk (https://hesk.com/) — fácil de instalar, configurar e manter.

---
## 🚀 Quick Start

Crie um arquivo chamado `docker-compose.yml` com o conteúdo abaixo e execute:

```bash
docker compose up 
```

## 🧱 compose.yml
```YAML
services:
  hesk:
    image: joaoprdo/hesk-helpdesk
    container_name: hesk_app
    restart: always
    healthcheck:
      test: ["CMD-SHELL", "curl -f http://localhost/index.php || exit 1"]
      interval: 30s
      timeout: 10s
      retries: 5
      start_period: 30s
    ports:
      - "8080:80"
    depends_on:
      - db
    environment:
      - HESK_DB_HOST=db
      - HESK_DB_NAME=hesk
      - HESK_DB_USER=hesk_user
      - HESK_DB_PASSWORD=hesk_password
    volumes:
      - hesk_attachments:/var/www/html/attachments
      - hesk_cache:/var/www/html/cache

  db:
    image: mysql:5.7
    container_name: hesk_db
    restart: always
    healthcheck:
      test: ["CMD", "mysqladmin", "ping", "-h", "localhost"]
      interval: 30s
      timeout: 10s
      retries: 5
      start_period: 30s
    environment:
      - MYSQL_ROOT_PASSWORD=root_password
      - MYSQL_DATABASE=hesk
      - MYSQL_USER=hesk_user
      - MYSQL_PASSWORD=hesk_password
    volumes:
      - hesk_db_data:/var/lib/mysql

volumes:
  hesk_db_data:
  hesk_attachments:
  hesk_cache:

```

## 🔗 Links Úteis

- **Site oficial HESK**: https://hesk.com/  
- **Repositório GitHub (Dockerfile + docs)**: https://github.com/joao-pedro-rdo/hesk-helpdesk-docker  
- **Docker Hub**: https://hub.docker.com/r/joaoprdo/hesk-helpdesk 

## instalação 

Após subir os containers com `docker-compose up -d`, acesse o instalador em http://localhost:8080/install e siga o passo‑a‑passo. Na configuração do banco de dados, use exatamente os mesmos valores definidos no seu `docker-compose.yml`. Quando a instalação for concluída, remova o


```bash
docker container exec -it hesk_app  bash
rm -r  install/
``` 
Com  tudo pronto acesse: http://localhost:8080/index.php
