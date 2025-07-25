# Card-Database

This is a full-stack web application for managing Pokémon cards, sets, customers, and orders. The app is built using **Node.js**, **Express**, **MySQL**, and **Handlebars**, and allows full **CRUD operations** for all data entities through a structured admin interface.

## Features

- Manage Pokémon cards, sets, customers, and orders
- Create, read, update, and delete entries from the database
- Join and relational queries to display related data (e.g., cards in a set, orders by customer)
- Handlebars-based user interface for admin interactions
- RESTful routing with Express
- Modularized backend using MVC structure

## Tech Stack

- **Frontend:** HTML, CSS, Handlebars
- **Backend:** Node.js, Express.js
- **Database:** MySQL
- **Other Tools:** Git, GitHub, dotenv, MySQL Workbench

## Installation

1. **Clone the Repository**
   ```bash
   git clone https://github.com/your-username/pokemon-database.git
   cd pokemon-database
Install Dependencies

bash
Copy
Edit
npm install
Database Setup

Create a MySQL database called pokemon_db (or whatever name is used in your .env)

Run the SQL schema file to create tables (cards, sets, customers, orders)

Optionally seed with initial data

Configure Environment

Create a .env file in the root:

ini
Copy
Edit
DB_HOST=localhost
DB_USER=your_mysql_username
DB_PASSWORD=your_mysql_password
DB_NAME=pokemon_db
Start the Server

bash
Copy
Edit
npm start
Open your browser and navigate to:

arduino
Copy
Edit
http://localhost:3000
Folder Structure
pgsql
Copy
Edit
pokemon-database/
├── controllers/
├── models/
├── public/
├── routes/
├── views/
│   ├── layouts/
│   └── partials/
├── .env
├── server.js
└── README.md
Functionality
Cards CRUD: Add/edit/remove Pokémon cards and associate them with sets

Sets CRUD: Manage card sets with release dates and descriptions

Customers CRUD: Add/edit/remove customer profiles

Orders CRUD: Create and manage orders linked to customers and cards

Future Improvements
Add authentication (admin login)

Upload and display images for Pokémon cards

Add filtering and search functionality

Improve UI with Tailwind or Bootstrap

License
This project is licensed under the MIT License.

Made with ❤️ for learning and fun

yaml
Copy
Edit

---

Let me know if you want to include screenshots, deploy it on something like Heroku or Vercel, or add a live 
