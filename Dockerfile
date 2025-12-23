# Используем минимальный образ Nginx
FROM nginx:alpine

# Копируем единственный файл
COPY index.html /usr/share/nginx/html/

# Настраиваем Nginx для эффективной работы
RUN echo 'server {\
    listen 80;\
    server_name _;\
    root /usr/share/nginx/html;\
    index index.html;\
    \
    # Базовые настройки безопасности\
    add_header X-Frame-Options "SAMEORIGIN" always;\
    add_header X-Content-Type-Options "nosniff" always;\
    \
    # Кэширование\
    location / {\
        expires 1h;\
        add_header Cache-Control "public, max-age=3600";\
        try_files $uri $uri/ =404;\
    }\
    \
    # Запрет доступа к скрытым файлам\
    location ~ /\. {\
        deny all;\
    }\
}' > /etc/nginx/conf.d/default.conf

# Открываем порт
EXPOSE 80

# Запускаем
CMD ["nginx", "-g", "daemon off;"]
