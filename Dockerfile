# Lightweight Python base image
FROM python:3.11-slim

# Prevent pyc files + better logs
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Working directory
WORKDIR /app

# System dependencies (required for many Python packages)
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Install pipenv (since you are using Pipfile)
RUN pip install pipenv

# Copy dependency files first (for caching)
COPY Pipfile Pipfile.lock ./

# Install production dependencies
RUN pipenv install --deploy --ignore-pipfile

# Copy application code
COPY . .

# Expose FastAPI port
EXPOSE 8000

# Run FastAPI with Gunicorn + Uvicorn workers (2 workers for 2 vCPU)
CMD ["pipenv", "run", "gunicorn",
     "-k", "uvicorn.workers.UvicornWorker",
     "main:app",
     "--bind", "0.0.0.0:8000",
     "--workers", "2",
     "--timeout", "120",
     "--keep-alive", "5"]