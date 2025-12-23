# Используем легкий образ Python
FROM python:3.9-slim

# Устанавливаем рабочую директорию
WORKDIR /app

# Копируем зависимости и устанавливаем их
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Копируем исходный код приложения
COPY app.py .

# Открываем порт, на котором работает приложение
EXPOSE 5000

# Команда для запуска приложения
CMD ["python", "app.py"]
