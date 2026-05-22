# obscura-http

HTTP API wrapper around [obscura](https://github.com/h4ckf0r0day/obscura) CDP — stealth headless browser.

## Endpoints

| Method | Path          | Body              | Response       |
| ------ | ------------- | ----------------- | -------------- |
| POST   | `/pdf`        | `{"url": "..."}` | binary PDF     |
| POST   | `/screenshot` | `{"url": "..."}` | binary PNG     |
| POST   | `/html`       | `{"url": "..."}` | HTML text      |

## Usage

```bash
# PDF
curl -X POST http://localhost:3100/pdf \
  -H "Content-Type: application/json" \
  -d '{"url":"https://example.com"}' \
  --output page.pdf

# Screenshot
curl -X POST http://localhost:3100/screenshot \
  -H "Content-Type: application/json" \
  -d '{"url":"https://example.com"}' \
  --output page.png

# HTML
curl -X POST http://localhost:3100/html \
  -H "Content-Type: application/json" \
  -d '{"url":"https://example.com"}'
```

## Docker

```bash
docker run -d -p 3100:3100 ghcr.io/painteau/obscura-http:latest
```

## Docker Compose

```yaml
services:
  obscura-http:
    image: ghcr.io/painteau/obscura-http:latest
    ports:
      - "3100:3100"
    restart: unless-stopped
```
