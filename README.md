# 🛒 Ecommerce SQL Project (MySQL + Docker + phpMyAdmin)

An expert-level ecommerce database system powered by MySQL, Docker, and phpMyAdmin. Includes schema, procedures, views, seed data, and UI for easy access.

---

## 🚀 Features

- Modular SQL: schema, seed data, views, procedures
- Dockerized MySQL 8 + phpMyAdmin
- Auto-executes SQL on first run
- UI at `http://localhost:8080`

---

## 📁 Structure

initdb/
├── 01-schema.sql
├── 02-procedures_views.sql
├── 03-seed_data.sql
├── 04-sample-data.sql
├── 05-queries.sql

yaml
Copy
Edit

---

## 🛠️ Setup

### 1. Clone & Run

```bash
git clone https://github.com/your-username/ecom-sql-project.git
cd ecom-sql-project
docker-compose up -d
2. Access
phpMyAdmin: localhost:8080

Server: mysql

User: ecomuser

Pass: ecom_pass123

MySQL CLI:

bash
Copy
Edit
docker exec -it ecommerce-mysql mysql -u ecomuser -p
🧠 Highlights
place_order() & adjust_stock() procedures

view_sales_summary view

Seeded users, products, orders, and payments

🔄 Reset DB
bash
Copy
Edit
docker-compose down -v
docker-compose up -d
✍️ Author
Your Name
GitHub: @noonsenseee