# מבוסס על התמונה של Maven
FROM maven:3.6.3-openjdk-8

# מגדיר את הפורט בו האפליקציה תרוץ
EXPOSE 8080

# משתני סביבה למאגר הנתונים ולפרופיל Spring
ENV DB_DIALECT HSQLDB
ENV DB_URL jdbc:hsqldb:file:lavagna
ENV DB_USER sa
ENV DB_PASS ""
ENV SPRING_PROFILE dev

# מעתיקים את קוד המקור לסביבת העבודה בתוך הקונטיינר
WORKDIR /app
COPY . /app

# בונים את האפליקציה בעזרת Maven
RUN mvn clean install

# יוצרים סקריפט הרצה עם ENTRYPOINT
COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

# מגדירים את נקודת הכניסה להרצת האפליקציה
ENTRYPOINT ["/app/entrypoint.sh"]
