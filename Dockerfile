# step 1: build stage using alpine for a smaller base image
FROM python:3.9-alpine AS builder

# dependencies for building python packages
RUN apk add --no-cache --virtual .build-deps gcc musl-dev libffi-dev

WORKDIR /app

COPY app.py requirements.txt static/ /app/

# install dependencies without caching the packages
RUN pip install --no-cache-dir --user -r requirements.txt && \
    apk del .build-deps

# step 2: final stage for production
FROM python:3.9-alpine

# set environment variables to prevent python from writing .pyc files and buffering output
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PATH=/root/.local/bin:$PATH

# Install runtime dependencies
RUN apk add --no-cache libffi

WORKDIR /app

# install dependencies from the builder stage
COPY --from=builder /root/.local /root/.local

COPY . .

EXPOSE 8080

CMD ["python", "app.py"]