.PHONY: all crawl build serve stop
PORT ?= 5001

crawl:
	@echo "==> Installing crawl deps (if needed)"
	cd crawl && yarn install --silent || true
	@echo "==> Running crawler"
	cd crawl && node index.js

build:
	@echo "==> Installing frontend deps (if needed)"
	cd frontend && yarn install --silent
	@echo "==> Building frontend"
	cd frontend && yarn build --silent

all: crawl build
	@echo "==> Done: crawl + build"

serve:
	@echo "==> Starting static server at http://localhost:$(PORT)"
	cd frontend && npx serve -s build -l $(PORT) &
	@sleep 1
	@echo "==> Server started on port $(PORT)"

stop:
	@echo "==> Stopping any 'serve' processes"
	@pkill -f "serve -s build" || true
	@echo "==> Done"
