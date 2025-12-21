COMPOSE_FILE=docker-compose.yaml

# Стандартные цели
.PHONY: build up down restart recreate rebuild

build:
 docker compose -f $(COMPOSE_FILE) --build

up:
 docker compose -f $(COMPOSE_FILE) up -d

down:
 docker compose -f $(COMPOSE_FILE) down

restart:
 docker compose -f $(COMPOSE_FILE) restart

recreate:
 docker compose -f $(COMPOSE_FILE) down && docker compose -f $(COMPOSE_FILE) up -d

rebuild:
 docker compose -f $(COMPOSE_FILE) build && docker compose -f $(COMPOSE_FILE) down && docker compose -f $(COMPOSE_FILE) up -d
 
