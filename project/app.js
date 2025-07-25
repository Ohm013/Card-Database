//
//  #Citation for the following code:
//  # Date: 5/07/2025
//  # scope: routing logic, showing the views of the handlebars, queries.
//  # originality: Adapted from starter code Build app.js.
//  # Exploration - Web Application Technology
//  # originality: Adapted from starter code for CUD ROUTES
//  # Exploration - Implementing CUD operations in your app
//  # Source URL: https://canvas.oregonstate.edu/courses/1999601/pages/exploration-web-application-technology-2?module_item_id=25352948 
//  # Source URL: https://canvas.oregonstate.edu/courses/1999601/pages/exploration-implementing-cud-operations-in-your-app?module_item_id=25352968

// ########################################
// ########## SETUP

// Express
const express = require('express');
const app = express();
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(express.static('public'));

const PORT = 46971;


// Database
const db = require('./database/db-connector');


//  #Citation for the helper function:
//  # Date: 5/31/2025
//  # scope: Helper function to format the SQL DATE values 
//  # originality: Adapted with AI help
//  # Summary of prompt
// I asked how to format my app.js to have my DATE in my sql files show as a string without so much information just for example 
// “Fri Nov 08 2024”,  and it suggest to add a helper function in the '.hbs', engine. and use `Date` and `toDateString()`
//  # AI Source URL: https://chat.openai.com 
//  
// Handlebars
const { engine } = require('express-handlebars'); // Import express-handlebars engine
app.engine('.hbs', engine({ 
    extname: '.hbs',
    helpers: {
      formatDate:  function (date) {
         if (!date) return '';
            return new Date(date).toDateString();
      }
    } 
})); // Create instance of handlebars
app.set('view engine', '.hbs'); // Use handlebars engine for *.hbs files.


// ########################################
// ########## ROUTE HANDLERS

// READ ROUTES
app.get('/', async function (req, res) {
    
    try {
        res.render('home'); // Render the home.hbs file

    } catch (error) {
        console.error('Error rendering page:', error);
        // Send a generic error message to the browser
        res.status(500).send('An error occurred while rendering the page.');
    }
});

app.get('/pokemon_cards', async function (req, res) {
    try {
        // Create and execute our queries
        const query1 = `SELECT cards.card_id, cards.name, cards.set_id, \
            cards.rarity, cards.condition, cards.condition, cards.type, cards.price FROM cards
            INNER JOIN sets ON cards.set_id = sets.set_id;`; 
        const setsQuery = 'SELECT set_id, set_name FROM sets;';

        const [cards] = await db.query(query1);
        const [sets] = await db.query(setsQuery);

       
        res.render('pokemon_cards', { cards: cards, sets: sets });
    } catch (error) {
        console.error('Error executing queries:', error);
        res.status(500).send(
            'An error occurred while executing the database queries.'
        );
    }
});


app.get('/sets', async function (req, res) {
    try {
        
        const query1 = `SELECT sets.set_id, sets.set_name, sets.release_date FROM sets` 
        const query2 = 'SELECT * FROM sets;';
        const [sets] = await db.query(query1);
        const [allSets] = await db.query(query2);

       
        res.render('sets', { sets: sets, allSets: allSets });
    } catch (error) {
        console.error('Error executing queries:', error);
        // Send a generic error message to the browser
        res.status(500).send(
            'An error occurred while executing the database queries.'
        );
    }
});

app.get('/customers', async function (req, res) {
    try {
        
        const query1 = `SELECT customers.customer_id, customers.customer_id, customers.first_name,
        customers.last_name, customers.email, customers.phone_number FROM customers` 

        const query2 = 'SELECT * FROM customers;';

        const [customers] = await db.query(query1);
        const [allCustomers] = await db.query(query2);

       
        res.render('customers', { customers: customers, allCustomers: allCustomers });
    } catch (error) {
        console.error('Error executing queries:', error);
        // Send a generic error message to the browser
        res.status(500).send(
            'An error occurred while executing the database queries.'
        );
    }
});
app.get('/orders', async function (req, res) {
    try {

        const query1 = `SELECT orders.order_id, orders.customer_id, orders.order_date,
        orders.quantity, customers.first_name, customers.last_name FROM orders
        LEFT JOIN customers on customers.customer_id = orders.customer_id` 
        const query2 = 'SELECT customer_id, first_name, last_name FROM customers;';
        // get card data
        const query3 = 'SELECT card_id, name FROM cards;';

        // get orders cards info
        const query4 = `SELECT orders_cards.order_card_id, orders_cards.order_id, cards.name AS card_name,
        customers.first_name, customers.last_name
        FROM orders_cards
        INNER JOIN orders ON orders.order_id = orders_cards.order_id
        LEFT JOIN customers ON customers.customer_id = orders.customer_id
        INNER JOIN cards ON cards.card_id = orders_cards.card_id;`;

        const [orders] = await db.query(query1);
        const [allOrders] = await db.query(query2);
        const [cards] = await db.query(query3);
        const [orders_cards] = await db.query(query4);

        res.render('orders', { 
            orders: orders, 
            customers: allOrders,
            cards: cards,
            orders_cards: orders_cards
         });
    } catch (error) {
        console.error('Error executing queries:', error);
        // Send a generic error message to the browser
        res.status(500).send(
            'An error occurred while executing the database queries.'
        );
    }
});

app.get('/orders_cards', async function (req, res) {
    
    try {
        const query1 = `SELECT orders_cards.order_card_id, orders_cards.order_id, orders_cards.card_id, cards.name AS card_name,
        orders_cards.price, orders_cards.quantity, orders_cards.total
        FROM orders_cards
        LEFT JOIN cards ON orders_cards.card_id = cards.card_id;`;

        const query2 = `SELECT orders.order_id, customers.first_name, customers.last_name
        FROM orders
        INNER JOIN customers ON customers.customer_id = orders.customer_id;`;
  
        const query3 = 'SELECT card_id, price, name FROM cards;';
  
        const [orders_cards] = await db.query(query1);
        const [orders] = await db.query(query2);
        const [cards] = await db.query(query3);

        res.render('orders_cards', {orders_cards: orders_cards, orders: orders, cards: cards});

    } catch (error) {
      console.error('Error executing queries:', error);
      res.status(500).send(
        'An error occurred while executing the database queries.'
      );
    }
});

// ======================
// CUD FOR Cards
// ======================
// CREATE Route
app.post('/pokemon_cards', async function (req, res) {
    try {
        // Parse frontend form information
        let data = req.body;

        // Cleanse data - If the homeworld or age aren't numbers, make them NULL.

        if (data.set_id === 'NULL') {
            data.set_id = null;
        }

        await db.query('CALL sp_CreateCard(?, ?, ?, ?, ?, ?, @new_id);', [ // query to create card sp
            data.card_name,
            data.card_rarity,
            data.card_condition,
            data.card_type,
            data.card_price || 0.00,
            data.set_id
        ]);

    // 2. Select the output value of @new_id
        const [[result]] = await db.query('SELECT @new_id AS new_id');
        const newId = result.new_id;

        console.log(`Created new card with ID: ${newId}`);

        // Redirect the user to the updated webpage
        res.redirect('/pokemon_cards');
    } catch (error) {
        console.error('Error executing queries:', error);
        // Send a generic error message to the browser
        res.status(500).send(
            'An error occurred while executing the database queries.'
        );
    }
});

// UPDATE ROUTES
app.post('/pokemon_cards/update', async function (req, res) {
    try {
        // Parse frontend form information
        const data = req.body;

        // Cleanse data - make them NULL.
        if (isNaN(parseFloat(data.update_card_price)))
            data.update_card_price = null;
        if (isNaN(parseInt(data.update_card_set)))
            data.update_card_set = null;


        // Create and execute our query
        // Using parameterized queries (Prevents SQL injection attacks)
        const query1 = 'CALL sp_UpdateCard(?, ?, ?, ?, ?, ?, ?);';

        await db.query(query1, [
            data.update_card_id,
            data.update_card_name,
            data.update_card_rarity,
            data.update_card_condition,
            data.update_card_type,
            data.update_card_price,
            data.update_card_set,
        ]);

        console.log(`UPDATE card ID: ${data.update_card_id} ` +
            `Name: ${data.update_card_name} `
        );

        // Redirect the user to the updated webpage data
        res.redirect('/pokemon_cards');
    } catch (error) {
        console.error('Error updading card:', error);
        // Send a generic error message to the browser
        res.status(500).send(
            'An error occurred while updating a card.'
        );
    }
});


// DELETE ROUTES
app.post('/pokemon_cards/delete', async function (req, res) {
    try {
        // Parse frontend form information
        let data = req.body;

        // Create and execute our query
        // Using parameterized queries (Prevents SQL injection attacks)
        const query1 = `CALL sp_DeleteCard(?);`;
        await db.query(query1, [data.delete_card_id]);

        console.log(`DELETE card. ID: ${data.delete_card_id} ` 
        );

        // Redirect the user to the updated webpage data
        res.redirect('/pokemon_cards');
    } catch (error) {
        console.error('Error deleting cards:', error);
        // Send a generic error message to the browser
        res.status(500).send(
            'An error occurred while deleting a card.'
        );
    }
});


// ======================
// CUD FOR sets
// ======================

// CREATE ROUTES
app.post('/sets/create', async function (req, res) {
    try {
        // Parse frontend form information
        let data = req.body;

        // Create and execute our queries
        // Using parameterized queries (Prevents SQL injection attacks
        
        await db.query(`CALL sp_CreateSet(?, ?, @new_id);`, [
            data.set_name,
            data.release_date,
        ]);

        const[rows] = await db.query(`SELECT @new_id AS new_id`);
        const newID = rows[0].new_id;

        console.log(`CREATE set. ID: ${newID} ` 
        );

        // Redirect the user to the updated webpage
        res.redirect('/sets');
    } catch (error) {
        console.error('Error inserting sets:', error);
        // Send a generic error message to the browser
        res.status(500).send(
            'An error occurred while adding a set.'
        );
    }
});


// UPDATE ROUTES
app.post('/sets/update', async function (req, res) {
    try {
        // Parse frontend form information
        const data = req.body;

        // Create and execute our query
        // Using parameterized queries (Prevents SQL injection attacks)
        const query1 = 'CALL sp_UpdateSet(?, ?, ?);';
        await db.query(query1, [
            data.update_set_id,
            data.update_set_name,
            data.update_release_date,
        ]);

        console.log(`UPDATE set_id ID: ${data.update_set_id} ` +
            `Name: ${data.update_set_name} `
        );

        // Redirect the user to the updated webpage data
        res.redirect('/sets');
    } catch (error) {
        console.error('Error executing sets:', error);
        // Send a generic error message to the browser
        res.status(500).send(
            'An error occurred while updating the set'
        );
    }
});


// ======================
// CUD FOR customers
// ======================

// CREATE ROUTES customers
app.post('/customers/create', async function (req, res) {
    console.log('/customers/create was accessed')
    try {
        // Parse frontend form information
        let data = req.body;

        // Create and execute our queries
        // Using parameterized queries (Prevents SQL injection attacks)

        const result = await db.query(`CALL sp_CreateCustomer(?, ?, ?, ?, @new_id);`, [
            data.first_name,
            data.last_name,
            data.email,
            data.phone_number,
        ]);

        // Then, fetch the new ID from the session variable
        const [rows] = await db.query(`SELECT @new_id AS new_id`);
        const newID = rows[0].new_id;

        console.log(`CREATE New Customer ID: ${newID}`);

        // Redirect the user to the updated webpage
        res.redirect('/customers');
    } catch (error) {
        console.error('Error inserting customer:', error);
        // Send a generic error message to the browser
        res.status(500).send(
            'An error occurred while adding a customer'
        );
    }
});

// UPDATE ROUTES
app.post('/customers/update', async function (req, res) {
    try {
        // Parse frontend form information
        const data = req.body;

        // Create and execute our query
        // Using parameterized queries (Prevents SQL injection attacks)
        const query1 = 'CALL sp_UpdateCustomer(?, ?, ?, ?, ?);';
        await db.query(query1, [
            data.update_customer_id,
            data.update_first_name,
            data.update_last_name,
            data.update_email,
            data.update_phone_number,
        ]);

        console.log(`UPDATE customeer ID: ${data.update_customer_id} `
        );

        // Redirect the user to the updated webpage data
        res.redirect('/customers');
    } catch (error) {
        console.error('Error updating customer:', error);
        // Send a generic error message to the browser
        res.status(500).send(
            'An error occurred while updating customer'
        );
    }
});

// DELETE ROUTES
app.post('/customers/delete', async function (req, res) {
    try {
        // Parse frontend form information
        let data = req.body;

        // Create and execute our query
        // Using parameterized queries (Prevents SQL injection attacks)
        const query1 = `CALL sp_DeleteCustomer(?);`;
        await db.query(query1, [data.delete_customer_id]);

        console.log(`DELETE customer. ID: ${data.delete_customer_id} `
        );
        // Redirect the user to the updated webpage data
        res.redirect('/customers');
    } catch (error) {
        console.error('Error deleting customer:', error);
        // Send a generic error message to the browser
        res.status(500).send(
            'An error occurred while deleting the customer.'
        );
    }
});

// ======================
// CUD FOR Orders
// ======================
// CREATE ROUTES
app.post('/orders/create', async function (req, res) {
    try {
        // Parse frontend form information
        let data = req.body;

        // Cleanse data if it is not a number
        if (isNaN(parseInt(data.quantity)))
            data.quantity = null;

        // Create and execute our queries
        // Using parameterized queries (Prevents SQL injection attacks)
        const query1 = `CALL sp_CreateOrder(?, ?, ?, ?, @new_id);`;

        // Store ID of last inserted row
        const [[[rows]]] = await db.query(query1, [
            data.customer_id,
            data.order_date,
            data.quantity,
            data.card_id,
        ]);

        console.log(`CREATE order. ID: ${rows.new_id} ` +
            `For Customer: ${data.customer_id}`
        );

        // Redirect the user to the updated webpage
        res.redirect('/orders');
    } catch (error) {
        console.error('Error creating order:', error);
        // Send a generic error message to the browser
        res.status(500).send(
            'An error occurred while creating an order.'
        );
    }
});

// UPDATE ROUTES
app.post('/orders/update', async function (req, res) {
    try {
        // Parse frontend form information
        const data = req.body;

        // Cleanse data
        if (isNaN(parseInt(data.update_quantity)))
            data.update_quantity = null;

        // Create and execute our query
        // Using parameterized queries (Prevents SQL injection attacks)
        const query1 = 'CALL sp_UpdateOrder(?, ?, ?, ?);';
        await db.query(query1, [
            data.update_order_card_id,
            data.update_order_date,
            data.update_quantity,
            data.update_card_id
        ]);

        console.log(`UPDATE order. ID: ${data.update_order_card_id} ` 
        );

        // Redirect the user to the updated webpage data
        res.redirect('/orders');
    } catch (error) {
        console.error('Error executing orders:', error);
        // Send a generic error message to the browser
        res.status(500).send(
            'An error occurred while updating orders.'
        );
    }
});

// ========================
// UPDATE for orders_cards
// ========================
// UPDATE ROUTES
app.post('/orders_cards/update', async function (req, res) {
    try {
        // Parse frontend form information
        const data = req.body;

        // Create and execute our query
        // Using parameterized queries (Prevents SQL injection attacks)
        const query1 = 'CALL sp_UpdateOrderCard(?, ?);';
        await db.query(query1, [
            data.update_order_card_id,
            data.update_card_id
        ]);

        console.log(`UPDATE card for order ID: ${data.update_order_card_id} ` 
        );

        // Redirect the user to the updated webpage data
        res.redirect('/orders_cards');
    } catch (error) {
        console.error('Error updating order_cards:', error);
        // Send a generic error message to the browser
        res.status(500).send(
            'An error occurred while updating orders_cards.'
        );
    }
});

// DELETE ROUTES
app.post('/orders/delete', async function (req, res) {
    try {
        // Parse frontend form information
        let data = req.body;

        // Create and execute our query
        // Using parameterized queries (Prevents SQL injection attacks)
        const query1 = `CALL sp_DeleteOrder(?);`;
        await db.query(query1, [data.delete_order_id]);

        console.log(`DELETE order. ID: ${data.delete_order_id} ` 
        );

        // Redirect the user to the updated webpage data
        res.redirect('/orders');
    } catch (error) {
        console.error('Error deleting orders:', error);
        // Send a generic error message to the browser
        res.status(500).send(
            'An error occurred while deleting an order.'
        );
    }
});

// ======================
// RESET FOR DATABASE
// ======================

// DELETE ROUTES
app.post('/reset-database', async function (req, res) {
    try {
        await db.query('CALL sp_reset_db();');

        console.log(`Reset Database to orginal state`);

        // Redirect the user to the updated webpage data
        res.redirect('/');
    } catch (error) {
        console.error('Error resetting database:', error);
        // Send a generic error message to the browser
        res.status(500).send(
            'An error occurred while resetting the database'
        );
    }
});


// ########################################
// ########## LISTENER

app.listen(PORT, function () {
    console.log(
        'Express started on http://localhost:' +
            PORT +
            '; press Ctrl-C to terminate.'
    );
});

